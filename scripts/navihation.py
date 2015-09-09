#!/usr/bin/env python

""" nav_test.py - Version 0.1 2012-01-10

    Command a robot to move autonomously among a number of goal locations defined in the map frame.
    On each round, select a new random sequence of locations, then attempt to move to each location
    in succession.  Keep track of success rate, time elapsed, and total distance traveled.

    Created for the Pi Robot Project: http://www.pirobot.org
    Copyright (c) 2012 Patrick Goebel.  All rights reserved.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.5
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details at:
    
    http://www.gnu.org/licenses/gpl.html
      
"""

import rospy
import actionlib
from actionlib_msgs.msg import *
from geometry_msgs.msg import Pose, PoseWithCovarianceStamped, Point, Quaternion, Twist
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from messages.msg import Camino,Punto
from random import sample
from math import pow, sqrt, atan, degrees
from Quaternion import Quat

from scipy.interpolate import UnivariateSpline
import numpy as np
from pantilt import Pantilt

from threading import Thread
import time

anguloRobot = 0.0 #se Actualiza cada vez que se mueve
point_between_point = 1

class NavTest():
    def __init__(self):
        self.puntos_a_seguir = list()
        self.ida = True #Indicando que es camino de ida del guardian_mode
        self.pan_tilt = []
        self.lista_tiempos = []

        #self.puntosGuardian()

        rospy.init_node('nav_test', anonymous=True)
        
        rospy.on_shutdown(self.shutdown)
        
        # How long in seconds should the robot pause at each location?
        #self.rest_time = rospy.get_param("~rest_time", 0.01)
        
        # Are we running in the fake simulator?
        self.fake_test = rospy.get_param("~fake_test", False)
        
        # Goal state return values
        goal_states = ['PENDING', 'ACTIVE', 'PREEMPTED', 
                       'SUCCEEDED', 'ABORTED', 'REJECTED',
                       'PREEMPTING', 'RECALLING', 'RECALLED',
                       'LOST']
        
        # Publisher to manually control the robot (e.g. to stop it)
        self.cmd_vel_pub = rospy.Publisher('cmd_vel', Twist)

        self.__sub_camino = rospy.Subscriber("chatter", Camino, self.chatter_handler)
        
        # Subscribe to the move_base action server
        self.move_base = actionlib.SimpleActionClient("move_base", MoveBaseAction)
        
        rospy.loginfo("Waiting for move_base action server...")
        
        # Wait 60 seconds for the action server to become available
        self.move_base.wait_for_server(rospy.Duration(60))
        
        rospy.loginfo("Connected to move base server")
        
        # A variable to hold the initial pose of the robot to be set by 
        # the user in RViz
        initial_pose = PoseWithCovarianceStamped()
        
        # Variables to keep track of success rate, running time,
        # and distance traveled
        location = ""
        last_location = ""
        
        # Get the initial pose from the user
        rospy.loginfo("*** Click the 2D Pose Estimate button in RViz to set the robot's initial pose...")
        rospy.wait_for_message('initialpose', PoseWithCovarianceStamped)
        self.last_location = Pose()
        rospy.Subscriber('initialpose', PoseWithCovarianceStamped, self.update_initial_pose)
        
        # Make sure we have the initial pose
        while initial_pose.header.stamp == "":
            rospy.sleep(1)
            
        rospy.loginfo("Starting navigation test")

        cont_pan_tilt = 0 
        aux = 0
        
        # Begin the main loop and run through a sequence of locations
        while not rospy.is_shutdown():
            # Get the next location in the current sequence
            location,ang_pan_tilt,tiempo_por_punto = self.puntosGuardian(last_location)
            
            # Store the last location for distance calculations
            last_location = location
        
            # Set up the next goal location
            self.goal = MoveBaseGoal()
            self.goal.target_pose.pose = location
            self.goal.target_pose.header.frame_id = 'map'
            self.goal.target_pose.header.stamp = rospy.Time.now()
           
            #threads = list()
            #t = Thread(target=self.panTilt_Handle(ang_pan_tilt[0],ang_pan_tilt[1])) #ang_pan_tilt[0],ang_pan_tilt[1]
            #threads.append(t)
            #t.start()

            # Start the robot toward the next location
            self.move_base.send_goal(self.goal)
            
            # Allow 20 seconds to get there
            # Quizas no sea necesario esperar, si no que un sleep y ver si se logro y mandar altiro el otro
            
            print "Tiempo de dormir", tiempo_por_punto
            time.sleep(tiempo_por_punto)
            #rospy.sleep(tiempo_por_punto)
            #finished_within_time = self.move_base.wait_for_result(rospy.Duration(tiempo_por_punto)) 
            
            # Check for success or failure
            state = self.move_base.get_state()
            if state == GoalStatus.SUCCEEDED:
                rospy.loginfo("Goal succeeded!")
                #n_successes += 1
                #distance_traveled += distance
                rospy.loginfo("State:" + str(state))
            else:
              rospy.loginfo("Goal failed with error code: ")
            
            # How long have we been running?
            #running_time = rospy.Time.now() - start_time
            #running_time = running_time.secs / 60.0
            
            #rospy.sleep(self.rest_time)
            
    def update_initial_pose(self, initial_pose):
        self.initial_pose = initial_pose

    def shutdown(self):
        rospy.loginfo("Stopping the robot...")
        self.move_base.cancel_goal()
        rospy.sleep(2)
        self.cmd_vel_pub.publish(Twist())
        rospy.sleep(1)

    def panTilt_Handle(self,pan,tilt):
        pantilt = Pantilt('/dev/ttyUSB2',9600) #Change port and baudrate
        pantilt.open()

        pantilt.set_angle(pan,tilt) #pan,tilt

        #time.sleep(5)

        pantilt.close()

    def chatter_handler(self,data):
        x_total = []
        y_total = []
        self.pan_total =[]
        self.tilt_total = []
        tiempo_total = []

        x = []
        y = []
        ang_pan =[]
        ang_tilt = []
        tiempo = []

        for point in data.punto:
            if abs(point.y) < abs(y[-1]):
                x_total.append(x)
                y_total.append(y)
                ang_pan_total.append(ang_pan)
                ang_tilt_total.append(ang_tilt)
                tiempo_total.append(tiempo)

                x = []
                y = []
                ang_pan =[]
                ang_tilt = []
                tiempo = []

            x.append(point.x)
            y.append(point.y)
            ang_pan.append(point.angulo_pan)
            ang_tilt.append(point.angulo_tilt)
            tiempo.append(point.tiempo)

        x_total.append(x)
        y_total.append(y)
        ang_pan_total.append(ang_pan)
        ang_tilt_total.append(ang_tilt)
        tiempo_total.append(tiempo)

        puntos = []
        for i in range(len(x_total)):
            self.agregarPuntosCamino(x_total[i],y_total[i],puntos,ang_pan_total[i], ang_tilt_total[i],tiempo_total[i])

    def agregarPuntosCamino(self,x,y,puntos = [], pan = 0, tilt = 0, tiempo = None):
        if len(x) > 3 and point_between_point > 1:
            spl = UnivariateSpline(x, y)
            xs = np.linspace(min(x),max(x),len(x)*point_between_point)
            spl.set_smoothing_factor(0.5)
            ys = spl(xs)

            pans = []
            tilts = []
            tiempos = []
            for i in range(len(pan)):
                pans += [pan[i]/point_between_point]*point_between_point
                tilts += [tilt[i]/point_between_point]*point_between_point
                tiempos += [tiempo[i]/point_between_point]*point_between_point
        else:
            xs = x
            ys = y
            pans = pan
            tilts = tilt
            tiempos = tiempo

        if len(puntos) == 0:
            self.puntos_a_seguir = []
            self.pan_tilt = []
        
        ang_pos_final = 0
        q = None

        for i in range(len(xs)):
            if i == (len(xs) - 1):
                self.puntos_a_seguir.append(Pose(Point(xs[i], ys[i], 0.000), Quaternion(q.q[0], q.q[1], q.q[2], q.q[3]))) #
                self.pan_tilt.append([pans[i],tilts[i]])
                self.lista_tiempos.append(tiempos[i])
            else:
                ang_pos_final = degrees(atan(float(abs(ys[i+1]-ys[i]))/float(abs(xs[i+1]-xs[i]))))
                q = Quat((ang_pos_final,0,0))
                self.puntos_a_seguir.append(Pose(Point(xs[i], ys[i], 0.000), Quaternion(q.q[0], q.q[1], q.q[2], q.q[3]))) #q.q[0], q.q[1], q.q[2], q.q[3]
                self.pan_tilt.append([pans[i],tilts[i]])
                self.lista_tiempos.append(tiempos[i])

    def puntosGuardian(self,location):
        if len(self.puntos_a_seguir) < 2:
            x = [-52.0,-52.2,-52.3,-52.4,-52.5] #
            y = [8.0,7.8,7.7,7.6,7.5] #
            pan = [5,10,15,20,15]
            tilt = [1,2,3,4,5]
            tiempo = [20,20,20,20,20]
            if self.ida:
                self.ida = False
                x = list(reversed(x))
                y = list(reversed(y))
            else:
                self.ida = True

            self.agregarPuntosCamino(x,y, puntos = [], pan = pan, tilt = tilt, tiempo = tiempo)

        if location == self.puntos_a_seguir[0]:
            self.puntos_a_seguir.pop(0)
            self.pan_tilt.pop(0)
            self.lista_tiempos.pop(0)
            print "Moving to ", self.puntos_a_seguir[0]
        return self.puntos_a_seguir[0],self.pan_tilt[0], self.lista_tiempos[0]
      
def trunc(f, n):
    # Truncates/pads a float f to n decimal places without rounding
    slen = len('%.*f' % (n, f))
    return float(str(f)[:slen])

if __name__ == '__main__':
    try:
        NavTest()
        rospy.spin()
    except rospy.ROSInterruptException:
        rospy.loginfo("AMCL navigation test finished.")