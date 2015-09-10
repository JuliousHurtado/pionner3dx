

import rospy
import actionlib
from actionlib_msgs.msg import *
from geometry_msgs.msg import Pose, PoseWithCovarianceStamped, Point, Quaternion, Twist
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from messages.msg import Camino,Punto,Pan_tilt
from random import sample
from math import pow, sqrt, atan, degrees,radians
import tf
from Quaternion import Quat

from pyturtlebot import get_robot

from scipy.interpolate import UnivariateSpline
import numpy as np
from pantilt import Pantilt

from threading import Thread
import time


class Navegar():
    robot = get_robot()

    def __init__(self):
        rospy.sleep(3)

        self.pan_tilt = []
        self.lista_tiempos = []

        #self.puntosGuardian()

        #rospy.init_node('nav_test', anonymous=True)
        
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

        self.__sub_pan_tilt = rospy.Publisher('pan_titl', Pan_tilt, queue_size=10)
        #rospy.init_node('talker', anonymous=True)
        
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

        self.punto_actual = None
        self.contador = 0

        while not rospy.is_shutdown():
            #print self.robot.plan[0]
            #print self.robot.plan[1]
            #print "-------------------------------------------------------"

            if self.verificarAvanzarCamino() and len(self.robot.plan) > 0:

                if self.robot.plan[self.contador] == self.punto_actual:
                    self.contador += 1
                else:
                    self.contador = 0

                self.punto_actual = self.robot.plan[self.contador+1]

                self.moverRobot(self.punto_actual,self.robot.plan[self.contador+2])

    def verificarAvanzarCamino(self):
        for i in range(self.robot.max_seg-1):
            tramo = self.robot.laser_range[self.robot.grados_sep*i:self.robot.grados_sep*(i+1)]
            if min(tramo) < 0.3 and (i > 3 or i < 15):
                self.robot.stop()
                return False
        return True

    def moverRobot(self,pose1,pose2):
        q1 = Quat((pose1.orientation.x,pose1.orientation.y,pose1.orientation.z,pose1.orientation.w))
        q2 = Quat((pose2.orientation.x,pose2.orientation.y,pose2.orientation.z,pose2.orientation.w))

        ang1 = radians(q2.ra - q1.ra)
        print ang1
        self.robot.turn_angle(ang1,1)

        dist = sqrt( (pose1.position.x - pose2.position.x)**2 + (pose1.position.y - pose2.position.y)**2 )
        print dist
        self.robot.move_distance(dist,1.0)

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

        time.sleep(3)

        punto = Pan_tilt()
        punto.pan = pan
        punto.tilt = tilt

        #self.__sub_pan_tilt(punto)
        self.pub_panTilt(pan,tilt)

        pantilt.close()

    def pub_panTilt(self,pan,tilt):
        br = tf.TransformBroadcaster()

        br.sendTransform((0.0, 0.0, 1.0),
                             tf.transformations.quaternion_from_euler(0, tilt, pan),
                             rospy.Time.now(),
                             "pan/tilt",
                             "base_link")

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
            tiempo = [30,30,30,30,30]
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
   

if __name__ == '__main__':
    try:
        Navegar()
        rospy.spin()
    except rospy.ROSInterruptException:
        rospy.loginfo("AMCL navigation test finished.")
