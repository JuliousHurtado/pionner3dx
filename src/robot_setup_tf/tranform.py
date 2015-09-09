#!/usr/bin/env python  
import roslib

import rospy
import tf

if __name__ == '__main__':
    rospy.init_node('pioneer')
    br1 = tf.TransformBroadcaster()
    br2 = tf.TransformBroadcaster()
    br3 = tf.TransformBroadcaster()
    br4 = tf.TransformBroadcaster()
    rate = rospy.Rate(10.0)
    while not rospy.is_shutdown():
        #br1.sendTransform((0.0, 0.0, 0.0),
        #                 (0.0, 0.0, 0.0, 1.0),
        #                 rospy.Time.now(),
        #                 "/base_link",
        #                 "/map")
        br2.sendTransform((0.0, 0.0, 0.0),
                         (0.0, 0.0, 0.0, 1.0),
                         rospy.Time.now(),
                         "/base_footprint",
                         "/odom")
        br3.sendTransform((0.0, 0.0, 0.0),
                         (0.0, 0.0, 0.0, 1.0),
                         rospy.Time.now(),
                         "/base_link",
                         "/base_footprint")
        
        br4.sendTransform((0.1, 0.0, 0.2),
                         (0.0, 0.0, 0.0, 1.0),
                         rospy.Time.now(),
                         "/laser",
                         "/base_link")
        """
        br4.sendTransform((0.034, 0.0, 0.25),
                         (0.0, 0.0, 0.0, 1.0),
                         rospy.Time.now(),
                         "/laser",
                         "/base_footprint")
        """
        rate.sleep()
