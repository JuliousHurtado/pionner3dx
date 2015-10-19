#!/usr/bin/env python

from pantilt import Pantilt
from common_code.msg import Pan_tilt
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

        self.s2 = rospy.Subscriber("/pan_tilt", Pan_tilt, self.handle_pan_tilt_change)

        rospy.spin()

    def handle_pan_tilt_change(self,data):
        self._pantilt_obj.set_angle(data.pan,data.titl)

if __name__ == "__main__":
    PanTilt()