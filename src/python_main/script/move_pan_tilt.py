#!/usr/bin/env python

from pantilt import Pantilt
from common_code.msg import Camino
from il_map_tools.srv import *
from Quaternion import Quat
import math
from geometry_msgs.msg import PoseWithCovarianceStamped

import rospy
import roslib
import time

class PanTilt(object):
    def __init__(self):
        print "Ready to deliver pan-tilt angles"
        rospy.init_node('pan_tilt_server')

        self._pan_angle = 0
        self._tilt_angle = 0
        self._pantilt_obj = Pantilt('/dev/ttyUSB2',9600)
        self._pantilt_obj.open()

        self.s1 = rospy.Service('pan_tilt_srv', Pan_tilt , self.handle_pan_tilt_srv)
        self.s2 = rospy.Subscriber("/caminos", Camino, self.handle_pan_tilt_change)
        self.amcl_sus = rospy.Subscriber("amcl_pose", PoseWithCovarianceStamped, self.__amcl_pose_handler)

        rospy.spin()

    def __amcl_pose_handler(self, data):
        actual_position = data.pose.pose

        self.x_act = actual_position.position.x
        self.y_act = actual_position.position.y
        self.ang_act = Quat((actual_position.orientation.x,actual_position.orientation.y,\
                                actual_position.orientation.z,actual_position.orientation.w))
    
    def handle_pan_tilt_srv(self,req):
        
        print "Returning (%f + %f)"%(self._pan_angle,self._tilt_angle,)
        return Pan_tiltResponse((self._pan_angle, self._tilt_angle))

    def handle_pan_tilt_change(self,camino):
        # TODO: compute optimal velocity
        
        #print camino
        #_pantilt_obj.set_velocity(200,200)

        #Ang of the robot: self.ang_act.ra
        #Ang of the pan: camino.puntos[0].angulo_pan

        for punto in camino.puntos:
            print punto.angulo_pan
            print self.ang_act.ra
            #_pantilt_obj.set_angle(self._pan_angle,self._tilt_angle)
            ang_mov_pan = self.ang_act.ra - punto.angulo_pan
            if ang_mov_pan > 158 or ang_mov_pan < -158:
                rospy.loginfo("Pan want to move more that limit")
                if ang_mov_pan < 0:
                    self._pantilt_obj.set_angle(-158,0)
                else:
                    self._pantilt_obj.set_angle(158,0)
            else:
                self._pantilt_obj.set_angle(ang_mov_pan,0)
            self._pan_angle = ang_mov_pan
            time.sleep(10)

if __name__ == "__main__":
    PanTilt()