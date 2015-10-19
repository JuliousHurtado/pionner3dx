import sys
import time
import numpy as np
import random

from math import radians

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


_turtlebot_singleton = None


def get_robot():
    global _turtlebot_singleton
    if _turtlebot_singleton is None:
        _turtlebot_singleton = Turtlebot()
    return _turtlebot_singleton


class Turtlebot(object):
    max_linear = 0.5 # 1.2
    max_angular = 0.6 # 3.0

    def __init__(self):
        #rospy.init_node('pioneer', anonymous=True)
        rospy.myargv(argv=sys.argv)

        self.__x = None
        self.__y = None
        self.__angle = None
        self.__cumulative_angle = 0.0
        self.__have_odom = False

        self.current_cv_image = None
        self.current_rgb_image = None
        self.current_cv_rgb_image = None
        self.current_mask = None
        self.current_depth_msg = None
        self.bridge = CvBridge()

        self.max_depth = None
        self.mean_depth = None
        self.mean_depth_r = None
        self.mean_depth_l = None
        self.mean_depth_right = None
        self.mean_depth_left = None
        self.grados_sep = 10 # grados de separacion
        self.max_seg = 180/self.grados_sep
        self.mean_range = [0]*self.max_seg
        self.laser_range = None

        self.obj_center_x = None
        self.obj_center_y = None 

        self.movement_enabled = True

        self.initial_pose = None
        self.plan = []
        self.angulo_pos = 0
        self.goal = None

        self.__cmd_vel_pub = rospy.Publisher('/RosAria/cmd_vel', Twist)
        #self.__cmd_vel_pub = rospy.Publisher('/cmd_vel', Twist)
        self.__odom_sub = rospy.Subscriber('/RosAria/pose', Odometry, self.__odom_handler)
        #self.__odom_sub = rospy.Subscriber('/odom', Odometry, self.__odom_handler)
        self.__scan_sub = rospy.Subscriber('/scan', LaserScan, self.__scan_handler)
        #self.__mapa_sub = rospy.Subscriber('/map', OccupancyGrid, self.__mapa_handler)

        #-----KINECT HANDLERS---#

        #para simulador
        #self.__depth_img = rospy.Subscriber('/camera/depth/image_raw',Image ,self.__depth_handler)
        #for real
        #self.__depth_img = rospy.Subscriber('/camera/depth/image_raw',Image ,self.__depth_handler)
        #self.__rgb_img= rospy.Subscriber('/camera/rgb/image_raw',Image,self.__rgb_handler)

    def moveManualRobot(self,diff_x,diff_y,diff_ang):
        print "Diferencia del angulo:",diff_ang
        self.turn_angle(radians(diff_ang), velocity=0.4)
        #self.move_distance((diff_x**2 + diff_y**2)**0.5, 0.3 )

        #dist = ((diff_x)**2 + (diff_y)**2)**0.5
        #msg = Twist()
        #msg.linear.x = 0.1
        #self.__cmd_vel_pub.publish(msg)

    def move(self, linear=0.0, angular=0.0,tiempo = 2 ,tiempo_wait = 1):
        """Moves the robot at a given linear speed and angular velocity
        The speed is in meters per second and the angular velocity is in radians per second
        """
        #self.__exit_if_movement_disabled()
        # Bounds checking
        if abs(linear) > self.max_linear:
            self.say("Whoa! Slowing you down to within +/-{0} m/s...".format(self.max_linear))
            linear = self.max_linear if linear > self.max_linear else linear
            linear = -self.max_linear if linear < -self.max_linear else linear
        if abs(angular) > self.max_angular:
            self.say("Whoa! Slowing you down to within +/-{0} rad/s...".format(self.max_angular))
            angular = self.max_angular if angular > self.max_angular else angular
            angular = -self.max_angular if angular < -self.max_angular else angular
        # Message generation
        msg = Twist()
        msg.linear.x = linear
        msg.angular.z = angular
        r = rospy.Rate(5) 
        # Announce and publish
        self.say("Moving ('{linear}' m/s, '{angular}' rad/s)...".format(linear=linear, angular=angular))
        #self.__cmd_vel_pub.publish(msg)
        for x in range(0,tiempo):
            self.__cmd_vel_pub.publish(msg)
            self.wait(tiempo_wait)
            #r.sleep()
        self.stop()

    def move_odom(self, distance, angle, vel_dist = 1.0, vel_ang = 1.0):
        r = rospy.Rate(1)
        while not self.__have_odom and not rospy.is_shutdown():
            self.say("Waiting for odometry")
            r.sleep()

        msg = Twist()
        msg.linear.x = vel_dist
        x0 = self.__x
        y0 = self.__y

        if angle >= 0:
            msg.angular.z = np.abs(vel_ang)
        else:
            msg.angular.z = -np.abs(vel_ang)
        angle0 = self.__cumulative_angle

        r = rospy.Rate(100)
        while not rospy.is_shutdown():
            d = ((self.__x - x0)**2 + (self.__y - y0)**2)**0.5
            a_diff = self.__cumulative_angle - angle0

            if (d >= distance) and ((angle >= 0 and a_diff >= angle) or (angle <= 0 and a_diff <= angle)):
                break

            if (angle >= 0 and a_diff >= angle) or (angle <= 0 and a_diff <= angle):
                msg.angular.z = 0.0
            if (d >= distance):
                msg.linear.x = 0.0

            self.__cmd_vel_pub.publish(msg)
            r.sleep()
            #print msg.angular.z
            #print msg.linear.x
            #print "Hola"
            #self.wait(0.02)

        msg.linear.x = 0.0
        msg.angular.z = 0.0
        self.__cmd_vel_pub.publish(msg)

    def move_distance(self, distance, velocity=1.0):
        """Moves a given distance in meters
        You can also give it a speed in meters per second to travel at:
            robot.move_distance(1, 0.5)  # Should take 2 seconds
        """
        #self.__exit_if_movement_disabled()
        # No bounds checking because we trust people. Not like William.
        r = rospy.Rate(1)
        while not self.__have_odom and not rospy.is_shutdown():
            self.say("Waiting for odometry")
            r.sleep()

        msg = Twist()
        msg.linear.x = velocity
        x0 = self.__x
        y0 = self.__y
        r = rospy.Rate(100)
        while not rospy.is_shutdown():
            d = ((self.__x - x0)**2 + (self.__y - y0)**2)**0.5
            if d >= distance:
                break

            self.__cmd_vel_pub.publish(msg)
            r.sleep()
        msg.linear.x = 0.0
        self.__cmd_vel_pub.publish(msg)

    def turn_angle_no_odo(self, angle, velocity=1.51992):
        """Turns the robot a given number of degrees in radians
        You can easily convert degress into radians with the radians() function:
            robot.turn_angle(radians(45))  # Turn 45 degrees
        You can also give an angular velocity to turn at, in radians per second:
            robot.turn_angle(radians(-45), radians(45))  # Turn back over a second
        """
        #self.__exit_if_movement_disabled()
        # No bounds checking because we trust people. Not like William.
        #r = rospy.Rate(1)
        #while not self.__have_odom and not rospy.is_shutdown():
        #    self.say("Waiting for odometry")
        #    r.sleep()

        msg = Twist()
        if angle < 0:
            angle = angle*-1
            velocity = velocity*-1  
        msg.angular.z = velocity
        #else:
        #    msg.angular.z = -np.abs(angle)
        #angle0 = self.__cumulative_angle
        #print angle0
        r = rospy.Rate(5)
        while not rospy.is_shutdown():
            for x in range(0,angle-1):
                self.__cmd_vel_pub.publish(msg)
                r.sleep() 
            break
            #a_diff = self.__cumulative_angle - angle0
            #print a_diff 
            #if (angle > 0 and a_diff >= angle) or (angle < 0 and a_diff <= angle):
            #    break

            #self.__cmd_vel_pub.publish(msg)
            #r.sleep()
        msg.angular.z = 0.0
        self.__cmd_vel_pub.publish(msg)

    def turn_angle(self, angle, velocity=1):
        """Turns the robot a given number of degrees in radians
        You can easily convert degress into radians with the radians() function:
            robot.turn_angle(radians(45))  # Turn 45 degrees
        You can also give an angular velocity to turn at, in radians per second:
            robot.turn_angle(radians(-45), radians(45))  # Turn back over a second
        """
        #self.__exit_if_movement_disabled()
        # No bounds checking because we trust people. Not like William.
        r = rospy.Rate(1)
        while not self.__have_odom and not rospy.is_shutdown():
            self.say("Waiting for odometry")
            r.sleep()

        msg = Twist()
        if angle >= 0:
            msg.angular.z = np.abs(velocity)
        else:
            msg.angular.z = -np.abs(velocity)
        angle0 = self.__cumulative_angle
        #print angle0
        r = rospy.Rate(100)
        while not rospy.is_shutdown():
            a_diff = self.__cumulative_angle - angle0
            #print a_diff 
            if (angle >= 0 and a_diff >= angle) or (angle <= 0 and a_diff <= angle):
                break

            self.__cmd_vel_pub.publish(msg)
            r.sleep()
        msg.angular.z = 0.0
        self.__cmd_vel_pub.publish(msg)

    def stop(self):
        """Stops the robot"""
        msg = Twist()
        msg.linear.x = 0.0
        msg.angular.z = 0.0
        #self.say("Stopping the robot!")
        self.__cmd_vel_pub.publish(msg)

    def wait(self, seconds):
        """This function will wait for a given number of seconds before returning"""
        #self.say("Waiting for '{0}' seconds.".format(seconds))
        time.sleep(seconds)

    def say(self, msg):
        """Prints a message to the screen!"""
        print(msg)
        sys.stdout.flush()
    
    def turn_around(self):
        self.turn_angle(np.pi)

    def random_angle(self):
        return random.uniform(-np.pi,np.pi)

    def turn_random(self):
        self.turn_angle(self.random_angle())

    def reset_movement(self):
        self.movement_enabled = True

    def show_laser(self):
        from IPython import display
        from pylab import subplot, show

        lm = self.current_laser_msg
        r = lm.ranges
        theta = [radians(90) + lm.angle_min + i * lm.angle_increment for i, x in enumerate(r)]

        ax = subplot(111, polar=True)
        ax.plot(theta, r, color='r', linewidth=3)
        ax.set_rmax(6)
        ax.grid(True)

        ax.set_title("A line plot of the laser data", va='bottom')
        show()

    def process_depth_image(self, img):
        img = img[:,65:-65]
        #img_aux = img[min_y:max_y, min_x:max_x]
        mm = np.max(img)
        self.mean_depth_right = np.mean(img[200:260, -60:-10])
        self.mean_depth_left = np.mean(img[200:260, 10:60])
        self.mean_depth = np.mean(img[200:260, 250:300])  
        self.mean_depth_l = np.mean(img[200:260, 245:270])
        self.mean_depth_r = np.mean(img[200:260, 280:305])
        #self.max_depth = len(img[:] [np.where( img[:] < 0.7 ) ])
        return img/mm    

    def process_image(self, frame):
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)      

        faces = self.faceCascade.detectMultiScale(
            gray,
            scaleFactor=1.8,
            minNeighbors=1,
            minSize=(160, 160),
            maxSize=(300, 300),
            flags=cv2.cv.CV_HAAR_SCALE_IMAGE
        )

        if len(faces) > 0:
            self.faceFound = len(faces)
        # Draw a rectangle around the faces
        for (x, y, w, h) in faces:
            cv2.rectangle(gray, (x, y), (x+w, y+h), (0, 255, 0), 2)

        # Display the resulting frame
        #cv2.imshow('Video', frame)
        return gray

    def __odom_handler(self, msg):
        self.__x = msg.pose.pose.position.x
        self.__y = msg.pose.pose.position.y
        q = msg.pose.pose.orientation
        a = trans.euler_from_quaternion([q.x, q.y, q.z, q.w])[2]

        # cumulative angle doesn't wrap. assumes we've not moved more than pi radians
        # since last odom message
        if self.__have_odom:
            a_diff = a - self.__angle
            if a_diff > np.pi:
                a_diff -= 2*np.pi
            elif a_diff < -np.pi:
                a_diff += 2*np.pi
            self.__cumulative_angle += a_diff

        self.__angle = a
        self.__have_odom = True

    def __scan_handler(self, msg):
        self.current_laser_msg = msg
        lm = self.current_laser_msg
        r = lm.ranges
        self.laser_range = r

        for i in range(self.max_seg):
            self.mean_range[i] = np.mean(r[self.grados_sep*i:self.grados_sep*(i+1)])

        rospy.sleep(1)

        #print self.mean_range
        #print "Min", msg.range_min
        #print "Max", msg.range_max
        #print "Largo Ranges", len(msg.ranges)
        #print "Mitad",msg.ranges[60:120]
        #print "Derecha",msg.ranges[:60]
        #print "Izquierda",msg.ranges[120:]
        
    def __exit_if_movement_disabled(self):
        if not self.movement_enabled:
            self.say("Movement currently disabled")
            sys.exit()

    def __depth_handler(self, data):
        try:
            self.current_depth_msg = data
            self.current_cv_image = self.bridge.imgmsg_to_cv(data,"32FC1")

            img = np.asarray(self.current_cv_image)
            #max_h, max_w = img.shape

            #depth_display_image = self.process_depth_image(img)
            #self.image = depth_display_image
            # Display the result
            #cv2.imshow("Depth Image", depth_display_image)
            
        except CvBridgeError, e:
            print e

    def __rgb_handler(self, data):
        try:
            self.current_rgb_image=data
            self.current_cv_rgb_image = self.bridge.imgmsg_to_cv(data,"bgr8")

            img = np.asarray(self.current_cv_rgb_image)
            #self.image = img

            #self.image = self.process_image(img)
            #print self.image.shape

            # Display the result
            #cv2.imshow("RGB Image", img)

        except CvBridgeError, e:
            print e

