#!/usr/bin/env python

import rospy
from Quaternion import Quat
from math import degrees,atan

from geometry_msgs.msg import Twist, Pose, PoseWithCovarianceStamped, Point, Quaternion
from common_code.msg import Camino,Punto
from messages.msg import Pan_tilt_mess,Orientacion

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
        self.punto_guardian = 0
        self.ida = True

        self.pan = 0
        self.tilt = 0

        self.take_initial_pose()
        self.amcl_sus = rospy.Subscriber("amcl_pose", PoseWithCovarianceStamped, self.__amcl_pose_handler)
        self.__sub_camino = rospy.Subscriber("caminos", Camino, self.chatter_handler)
        self.pub_pan_tilt = rospy.Publisher("/pan_tilt", Pan_tilt_mess, queue_size=10)
        self.pub_self_final_orientation = rospy.Publisher("final_orientation", Orientacion, queue_size = 5)

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
        if pose is not None:
            print pose
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
            self.agregarGoal()
            if diff_ang < 20:
                print "Cerca del angulo"

        return diff_x,diff_y,diff_ang

    def findOrientation(self,pose1,pose2):

        ang_pos_final = degrees(atan(float(abs(pose2.position.y-pose1.position.y))/float(abs(pose2.position.x-pose1.position.x))))
        #if pose2.position.x < pose1.position.x:
        #    ang_pos_final = ang_pos_final*-1
        q = Quat((ang_pos_final,0,0))

        return q

    def agregarGoal(self):
        pose = None
        if self.guardian:
            if self.ida:
                aux1 = self.punto_guardian
                aux2 = self.punto_guardian + 1
                self.punto_guardian += 1
            else:
                aux1 = self.punto_guardian
                aux2 = self.punto_guardian - 1
                self.punto_guardian -= 1

            pose1 = self.poses_guardian[aux1]
            pose2 = self.poses_guardian[aux2]

            q = self.findOrientation(pose1,pose2)
            pose = Pose(Point(pose1.position.x,pose1.position.y,pose1.position.z), Quaternion(q.q[0], q.q[1], q.q[2], q.q[3]))
            pose = None 
        else:
            pose = self.selfPoint()
            self.punto_guardian = 0
            self.move_pan_tilt()

        #print pose
        self.setGoal(pose)
        if self.punto_guardian == (len(self.poses_guardian) - 1):
            self.ida = False
        elif self.punto_guardian == 0:
            self.ida = True
        

    def move_pan_tilt(self):
        if self.guardian:
            if self.pan != 0 or self.tilt != 0:
                self.pan = 0
                self.tilt = 0

                pan_move = Pan_tilt_mess()
                pan_move.pan = 0
                pan_move.tilt = 0
                pan_move.reset = 1
                self.pub_pan_tilt.publish(pan_move)
            
        else:
            pan_move = Pan_tilt_mess()
            pan_move.pan = self.pan
            pan_move.tilt = self.tilt
            pan_move.reset = 0
            self.pub_pan_tilt.publish(pan_move)

    def __amcl_pose_handler(self, data):
        self.actual_position = data.pose.pose

        self.x_act = self.actual_position.position.x
        self.y_act = self.actual_position.position.y
        self.ang_act = Quat((self.actual_position.orientation.x,self.actual_position.orientation.y,\
                            self.actual_position.orientation.z,self.actual_position.orientation.w))

    def selfPoint(self):

        if len(self.waypoints) == 1:
            self.guardian = True
            self.self_point = False
            first = self.waypoints.pop(0)
            ang_pos_final = self.ang_act.ra

        else:
            first = self.waypoints.pop(0)
            sec = self.waypoints[0]

            ang_pos_final = degrees(atan(float(abs(sec[1]-first[1]))/float(abs(sec[0]-first[0]))))

            #if sec[0] < first[0]:
            #    ang_pos_final = ang_pos_final*-1

        q = Quat((ang_pos_final,0,0))

        location = Pose(Point(first[0],first[1],0),Quaternion(q.q[0], q.q[1], q.q[2], q.q[3]))

        self.pan = first[3]
        self.tilt = first[4]

        orin = Orientacion()
        orin.x = q.q[0]
        orin.y = q.q[1]
        orin.z = q.q[2]
        orin.w = q.q[3]
        self.pub_self_final_orientation.publish(orin)

        return location

    def chatter_handler(self,data):
        self.waypoints = []
        rospy.loginfo("Arrive new points from caminos")
        for point in data.puntos:
            self.waypoints.append([point.x,point.y,point.tiempo,point.angulo_pan,point.angulo_tilt])

        self.self_point = True
        self.guardian = False
        self.interrumpir = True