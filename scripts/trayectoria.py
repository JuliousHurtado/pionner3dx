import sys
import time
import numpy as np
import random
from Quaternion import Quat

from math import radians,degrees,atan

import rospy

from nav_msgs.msg import Path
from geometry_msgs.msg import Twist, Pose, PoseWithCovarianceStamped, Point, Quaternion
from nav_msgs.msg import Odometry, OccupancyGrid
from sensor_msgs.msg import LaserScan
from tf import transformations as trans
from sensor_msgs.msg import Image
from messages.msg import Camino,Punto

import cv2
from cv2 import cv
from cv_bridge import CvBridge, CvBridgeError

import actionlib
from actionlib_msgs.msg import *
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal


_trayectoria_singleton = None


def get_plan():
    global _trayectoria_singleton
    if _trayectoria_singleton is None:
        _trayectoria_singleton = Trayectoria()
    return _trayectoria_singleton


class Trayectoria(object):

    def __init__(self):
        rospy.init_node('trayectoria', anonymous=True)
        rospy.myargv(argv=sys.argv)

        #Real
        """
        self.x_guard = [1.0,0.0,-1.0,-3.0,-5.0,-7.0,-9.0,-11.0,-13.0,-15.0]
        self.y_guard = [1.0,0.0,0.0,-0.5,-0.5,-0.5,-0.5,-0.5,0.0,0.5]
        self.pan_guard = [0,0,0,0,0,0,0,0,0,0]
        self.tilt_guard = [0,0,0,0,0,0,0,0,0,0]
        self.tiempo_guard = [30,30,30,30,30,30,30,30,30,30]
        """
        #Oficina
        self.x_guard = [-3.570,-3.590,-3.610,-3.6300,-3.648]
        self.y_guard = [4.625,4.200,3.800,3.400,3.000]
        self.pan_guard = [0,0,0,0,0]
        self.tilt_guard = [0,0,0,0,0]
        self.tiempo_guard = [10,10,10,10,10]

        self.camino = []
        self.local_plan = [] #list
        self.global_plan = None #list
        self.goal = None #pose
        self.actual_position = None #pose

        self.contador_pos = 0 #int

        self.self_point = False #pose
        self.cancel_goal = False

        self.waypoints = None #list

        self.largoTrayectoria = len(self.x_guard)

        self.__sub_camino = rospy.Subscriber("chatter", Camino, self.chatter_handler)

        #rospy.on_shutdown(self.shutdown)
        # Subscribe to the move_base action server
        self.move_base = actionlib.SimpleActionClient("move_base", MoveBaseAction)
        rospy.loginfo("Waiting for move_base action server...")
        # Wait 60 seconds for the action server to become available
        self.move_base.wait_for_server(rospy.Duration(60))
        rospy.loginfo("Connected to move base server")
        
        # A variable to hold the initial pose of the robot to be set by 
        # the user in RViz
        initial_pose = PoseWithCovarianceStamped()

        # Get the initial pose from the user
        rospy.loginfo("*** Click the 2D Pose Estimate button in RViz to set the robot's initial pose...")
        rospy.wait_for_message('initialpose', PoseWithCovarianceStamped)
        self.last_location = Pose()
        rospy.Subscriber('initialpose', PoseWithCovarianceStamped, self.update_initial_pose)

        self.move_base = actionlib.SimpleActionClient("move_base", MoveBaseAction) 

        #self.__set_goal = rospy.Subscriber("move_base_simple/goal", Pose, self.__goal_handler)

        self.plan_local_sus = rospy.Subscriber("move_base/TrajectoryPlannerROS/local_plan", Path, self.__plan_local_handler)
        self.plan_global_sus = rospy.Subscriber("move_base/TrajectoryPlannerROS/global_plan", Path, self.__plan_global_handler)

        self.amcl_sus = rospy.Subscriber("amcl_pose", PoseWithCovarianceStamped, self.__amcl_pose_handler)


    def update_initial_pose(self, initial_pose):
        self.initial_pose = initial_pose

    def __plan_local_handler(self, data):
        self.local_plan = []

        #Ver que puntos agregar, cuales dejar fuera, etc.

        print "There is a new Local Plan"

        self.contador_pos = 0
        for point in data.poses:
            #diff_x = abs(point.pose.position.x - self.local_plan[-1].position.x)
            #diff_y = abs(point.pose.position.y - self.local_plan[-1].position.y)
            #if diff_x > 0.01 and diff_y > 0.01:
            self.local_plan.append(point.pose)
        """
        for point in data.poses:
            if self.local_plan is None or len(self.local_plan) == 0:
                self.local_plan.append(point.pose)
            else:
                agregar = True
                q1 = Quat((point.pose.orientation.x,point.pose.orientation.y,point.pose.orientation.z,point.pose.orientation.w))
                for local in self.local_plan:
                    q2 = Quat((local.orientation.x,local.orientation.y,local.orientation.z,local.orientation.w))
                    diff_x = abs(point.pose.position.x - local.position.x)
                    diff_y = abs(point.pose.position.y - local.position.y)
                    diff_ang = abs(radians(q1.ra) - radians(q2.ra))
                    if diff_x < 0.1 and diff_y < 0.1 and diff_ang < 0.2:
                        agregar = False
                        break
                if agregar:
                    self.local_plan.append(point.pose)

        """
        print "Largo del recorrido local: ",len(self.local_plan)


    def __plan_global_handler(self, data):
        self.global_plan = []

        for point in data.poses:
            self.global_plan.append(point.pose)

        print "Largo del recorrido Global: ",len(self.global_plan)

    def __amcl_pose_handler(self, data):
        self.actual_position = data.pose.pose

    def shutdown(self):
        rospy.loginfo("Stopping the robot...")
        self.move_base.cancel_goal()
        rospy.sleep(2)
        #self.cmd_vel_pub.publish(Twist())
        rospy.sleep(1)

    def guardianDCC(self,pos = 0, ida = True):
        x = self.x_guard
        y = self.y_guard
        pan = self.pan_guard
        tilt = self.tilt_guard
        tiempo = self.tiempo_guard

        self.self_point = True

        if ida:
            ang_pos_final = degrees(atan(float(abs(y[pos+1]-y[pos]))/float(abs(x[pos+1]-x[pos]))))
        else:
            ang_pos_final = degrees(atan(float(abs(y[pos]-y[pos-1]))/float(abs(x[pos]-x[pos-1]))))

        q = Quat((ang_pos_final,0,0))

        location = Pose(Point(x[pos],y[pos],0),Quaternion(q.q[0], q.q[1], q.q[2], q.q[3]))

        self.set_goal(location)

    def set_goal(self, location):
        self.goal = location

        goal = MoveBaseGoal()
        goal.target_pose.pose = location
        goal.target_pose.header.frame_id = 'map'
        goal.target_pose.header.stamp = rospy.Time.now()

        self.move_base.send_goal(goal)
        #Deberia mandar trayectoria
        #finished_within_time = self.move_base.wait_for_result(rospy.Duration(300)) 

    def reachGoal(self):

        q1 = Quat((self.actual_position.orientation.x,self.actual_position.orientation.y,self.actual_position.orientation.z,self.actual_position.orientation.w))
        q2 = Quat((self.goal.orientation.x,self.goal.orientation.y,self.goal.orientation.z,self.goal.orientation.w))

        diff_ang = abs(radians(q1.ra) - radians(q2.ra))
        diff_x = abs(self.goal.position.x - self.actual_position.position.x)
        diff_y = abs(self.goal.position.y - self.actual_position.position.y)

        if diff_x < 0.2 and diff_y < 0.2 and diff_ang < 0.2:
            print "Goal Reached :D!"
            return True
        else:
            return False

    def cancel_goal(self):
        self.move_base.cancel_goal()
        self.camino = []


    def selfPoint(self):
        first = self.waypoints.pop(0)
        sec = self.waypoints[0]

        ang_pos_final = degrees(atan(float(abs(sec[1]-first[1]))/float(abs(sec[0]-first[0]))))
        q = Quat((ang_pos_final,0,0))

        location = Pose(Point(first[0],first[1],0),Quaternion(q.q[0], q.q[1], q.q[2], q.q[3]))
        self.set_goal(location)        

    def chatter_handler(self,data):
        self.waypoints = []
        for point in data.punto:
            self.waypoints.append(point.x,point.y,point.tiempo)

        self.self_point = True