#!/usr/bin/env python

import rospy
from Quaternion import Quat
from math import degrees,atan

from geometry_msgs.msg import Twist, Pose, PoseWithCovarianceStamped, Point, Quaternion
from messages.msg import Camino,Punto

import actionlib
from actionlib_msgs.msg import *
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal

_trayectoria_singleton = None

def get_moving():
    global _trayectoria_singleton
    if _trayectoria_singleton is None:
        _trayectoria_singleton = Trayectoria()
    return _trayectoria_singleton


class Trayectoria(object):

    def __init__(self):
        rospy.init_node('nav_test', anonymous=True)
        rospy.myargv(argv=sys.argv)

        #Oficina
        #self.poses_guardian = [
        #    Pose(Point(-3.590, 4.100, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500)),
        #    Pose(Point(-3.610, 3.800, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500)),
        #    Pose(Point(-3.630, 3.400, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500)),
        #    Pose(Point(-3.648, 3.000, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500))
        #]

        #Pasillo
        self.poses_guardian = [
            Pose(Point(1.428, 1.352, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500)),
            Pose(Point(0.272, 0.919, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500)),
            Pose(Point(-1.023, -0.127, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500)),
            Pose(Point(-4.262, -0.196, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500)),
            Pose(Point(-6.970, -0.241, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500)),
            Pose(Point(-11.484, -0.326, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500))
            #Pose(Point(-17.747, 0.662, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500)),
            #Pose(Point(-23.181, 0.783, 0.000), Quaternion(0.000, 0.000, 0.892, -1.500))
        ]

        self.guardian = True
        self.goal_bool = False
        self.pose_goal = None

        self.actual_position = None

        self.interrumpir = False

        self.waypoints = []
        self.self_point = False

        self.take_initial_pose()
        self.amcl_sus = rospy.Subscriber("amcl_pose", PoseWithCovarianceStamped, self.__amcl_pose_handler)
        self.__sub_camino = rospy.Subscriber("caminos", Camino, self.chatter_handler)

    def take_initial_pose(self): 
    	#tell the action client that we want to spin a thread by default
        self.move_base = actionlib.SimpleActionClient("move_base", MoveBaseAction)
        rospy.loginfo("wait for the action server to come up")
        #allow up to 5 seconds for the action server to come up
        self.move_base.wait_for_server(rospy.Duration(5))

        initial_pose = PoseWithCovarianceStamped()
        # Get the initial pose from the user
        rospy.loginfo("*** Click the 2D Pose Estimate button in RViz to set the robot's initial pose...")
        rospy.wait_for_message('initialpose', PoseWithCovarianceStamped)
        self.last_location = Pose()
        rospy.Subscriber('initialpose', PoseWithCovarianceStamped, self.update_initial_pose)

    def update_initial_pose(self, initial_pose):
        self.initial_pose = initial_pose

    def shutdown(self):
    	self.move_base.cancel_goal()
        rospy.loginfo("Stop")

    def setGoal(self,pose):
    	#we'll send a goal to the robot to tell it to move to a pose that's near the docking station
        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = 'map'
        goal.target_pose.header.stamp = rospy.Time.now()
        #customize the following Point() values so they are appropriate for your location
        goal.target_pose.pose = pose
        #start moving
        self.move_base.send_goal(goal)

        self.pose_goal = pose
        self.goal_bool = True

    def checkProximityGoal(self):
    	diff_x = abs(self.pose_goal.position.x - self.x_act)
    	diff_y = abs(self.pose_goal.position.y - self.y_act)

    	q = Quat((self.pose_goal.orientation.x,self.pose_goal.orientation.y,\
                            self.pose_goal.orientation.z,self.pose_goal.orientation.w))
    	diff_ang = abs(self.ang_act.ra - q.ra)

    	if diff_x < 0.3 and diff_y < 0.3:
    		print "Cerca de goal en posicion"
    		if diff_ang < 20:
    			print "Cerca del angulo"

    	return diff_x,diff_y,diff_ang


    def __amcl_pose_handler(self, data):
        self.actual_position = data.pose.pose

        self.x_act = self.actual_position.position.x
        self.y_act = self.actual_position.position.y
        self.ang_act = Quat((self.actual_position.orientation.x,self.actual_position.orientation.y,\
                            self.actual_position.orientation.z,self.actual_position.orientation.w))

    def selfPoint(self):

        if len(self.waypoints) == 1:
            self.guardian = True
            first = self.waypoints.pop(0)
            ang_pos_final = self.ang_act.ra

        else:
            first = self.waypoints.pop(0)
            sec = self.waypoints[0]

            ang_pos_final = degrees(atan(float(abs(sec[1]-first[1]))/float(abs(sec[0]-first[0]))))

            if sec[0] < first[0]:
                ang_pos_final = ang_pos_final*-1

        q = Quat((ang_pos_final,0,0))

        location = Pose(Point(first[0],first[1],0),Quaternion(q.q[0], q.q[1], q.q[2], q.q[3]))

        return location

    def chatter_handler(self,data):
        self.waypoints = []
        rospy.loginfo("Arrive new points from caminos")
        for point in data.puntos:
            self.waypoints.append([point.x,point.y,point.tiempo])

        self.self_point = True
        self.guardian = False
        self.interrumpir = True