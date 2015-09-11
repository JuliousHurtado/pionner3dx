#!/usr/bin/env python

import sys
import rospy
from messages.srv import *
from il_map_tools.srv import *

def add_two_ints_client():
    rospy.wait_for_service('pan_tilt_srv')
    try:
        add_two_ints = rospy.ServiceProxy('pan_tilt_srv', Pan_tilt)
        resp1 = add_two_ints()
        print resp1
    except rospy.ServiceException, e:
        print "Service call failed: %s"%e

def usage():
    return "%s [x y]"%sys.argv[0]

if __name__ == "__main__":
    add_two_ints_client()