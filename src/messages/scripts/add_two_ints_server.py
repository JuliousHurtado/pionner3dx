#!/usr/bin/env python

from messages.srv import *
import rospy
from geometry_msgs.msg import PoseWithCovarianceStamped
from threading import Thread
from Quaternion import Quat

ang_pan = 0.0
ang_tilt = 0.0
ang_mapa = 0.0

class Pan_Tilt(object):

    def __init__(self):
        global ang_pan
        global ang_tilt

        self.pose_robot = None

        self.__pose_sub = rospy.Subscriber('/amcl_pose', PoseWithCovarianceStamped, self.__pose_handler)

        #self.seguir()

        while not rospy.is_shutdown():
            a = 0

    def seguir(self):
        global ang_pan
        global ang_tilt 

        ang_pan = 0
        ang_tilt = 0

    def __pose_handler(self,pose):
        global ang_mapa
        self.pose_robot = pose.pose

        x = self.pose_robot.quaternion.x
        y = self.pose_robot.quaternion.y
        z = self.pose_robot.quaternion.z
        w = self.pose_robot.quaternion.w

        q = Quat((x,y,z,w))

        ang_mapa = q.ra

        print q.ra

def handle_add_two_ints(seq):
    #print "Returning [%s + %s = %s]"%(req.a, req.b, (req.a + req.b))
    global ang_pan
    global ang_tilt
    global ang_mapa
    pan = ang_pan + ang_mapa
    #tilt = 20
    return pan,ang_tilt

def add_two_ints_server():
    rospy.init_node('add_two_ints_server')
    s = rospy.Service('add_two_ints', Pan_tilt, handle_add_two_ints)
    print "Ready to add two ints."
    rospy.spin()

if __name__ == "__main__":

    #Pan_Tilt()

    #t1 = Thread(target=add_two_ints_server) #ang_pan_tilt[0],ang_pan_tilt[1]
    t1 = Thread(target=Pan_Tilt) #ang_pan_tilt[0],ang_pan_tilt[1]
    t1.start()
    #t2.start()

    add_two_ints_server()