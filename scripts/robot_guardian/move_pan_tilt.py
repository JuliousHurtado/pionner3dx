#!/usr/bin/env python

from pantilt import Pantilt
from common_code.msg import Camino
from messages.msg import Pan_tilt_mess,Orientacion
from il_map_tools.srv import *
from Quaternion import Quat
import math
from geometry_msgs.msg import PoseWithCovarianceStamped

from math import radians,degrees
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

        self.x_act = 0
        self.y_act = 0
        self.ang_act = 0

        #self.s1 = rospy.Service('pan_tilt_srv', Pan_tilt_mess , self.handle_pan_tilt_srv)
        self.s2 = rospy.Subscriber("/pan_tilt", Pan_tilt_mess, self.handle_pan_tilt_change)
        #self.amcl_sus = rospy.Subscriber("amcl_pose", PoseWithCovarianceStamped, self.__amcl_pose_handler)
        self.amcl_sus = rospy.Subscriber("final_orientation", Orientacion, self.__orientacion_handler)
        self.s3 = rospy.Subscriber("/pan_tilt_tele", Pan_tilt_mess, self.handle_tele_op_pan_tilt)

        self.reset_cero()

        rospy.spin()

    def handle_tele_op_pan_tilt(self,data):
        self._pantilt_obj.set_angle(data.pan,data.tilt)


    def __amcl_pose_handler(self, data):
        actual_position = data.pose.pose

        self.x_act = actual_position.position.x
        self.y_act = actual_position.position.y
        self.ang_act = Quat((actual_position.orientation.x,actual_position.orientation.y,\
                                actual_position.orientation.z,actual_position.orientation.w))

    def __orientacion_handler(self, data):
        self.ang_act = Quat((data.x,data.y,data.z,data.w))
    
    def handle_pan_tilt_srv(self,req):
        
        print "Returning (%f + %f)"%(self._pan_angle,self._tilt_angle,)
        return Pan_tiltResponse((self._pan_angle, self._tilt_angle))

    def transformar_angulo(self,angulo):
        if angulo < 180:
            return angulo
        else:
            return angulo - 360

    def handle_pan_tilt_change(self,data):
        # TODO: compute optimal velocity
        
        #print camino
        #_pantilt_obj.set_velocity(200,200)

        #Ang of the robot: self.ang_act.ra
        #Ang of the pan: data.pan


        if data.reset == 1:
            self._pantilt_obj.set_angle(0,0)
        else:
            print "Angulo que llego en radianes:",data.pan
            print "Angulo del robot en radianes:",radians(self.ang_act.ra)
            print "Angulo que llego en grados:",degrees(data.pan)
            print "Angulo del robot en grados:",self.ang_act.ra
            #_pantilt_obj.set_angle(self._pan_angle,self._tilt_angle)
            ang_mov_pan = (self.ang_act.ra - degrees(data.pan))
            ang_mov_pan = self.transformar_angulo(ang_mov_pan)
            if ang_mov_pan > 158 or ang_mov_pan < -158:
                rospy.loginfo("Pan want to move more that limit")
                if ang_mov_pan < 0:
                    self._pantilt_obj.set_angle(-158,0)
                else:
                    self._pantilt_obj.set_angle(158,0)
            else:
                self._pantilt_obj.set_angle(ang_mov_pan,0)
            self._pan_angle = radians(ang_mov_pan)
        #time.sleep(0.5)

    def reset_cero(self):
        self._pantilt_obj.set_angle(0,0)

if __name__ == "__main__":
    PanTilt()