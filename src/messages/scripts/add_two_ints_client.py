#!/usr/bin/env python

import sys
import rospy
from messages.srv import *

def add_two_ints_client():
    rospy.wait_for_service('add_two_ints')
    try:
        add_two_ints = rospy.ServiceProxy('add_two_ints', Pan_tilt)
        resp1 = add_two_ints()
        print resp1
    except rospy.ServiceException, e:
        print "Service call failed: %s"%e

def usage():
    return "%s [x y]"%sys.argv[0]

if __name__ == "__main__":
    add_two_ints_client()