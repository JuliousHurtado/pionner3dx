import rospy
from math import pow, sqrt, atan, degrees,radians, pi
import tf
from Quaternion import Quat

from pyturtlebot import get_robot
from trayectoria import get_plan

import numpy as np

import time

def verificarAvanzarCamino(robot):
    for i in range(robot.max_seg-1):
        tramo = robot.laser_range[robot.grados_sep*i:robot.grados_sep*(i+1)]
        #Verificar estos valores
        if i > 2 and i < 16:
            if i in [8,9,10,11] and min(tramo) < 0.3:
                print "There is something in the way!!!"
                robot.stop()
                #robot.wait(5)
                robot.turn_angle(caminoDespejado(robot))
                return False
            if i in [6,7,12,13] and min(tramo) < 0.2:
                print "There is something in the way!!!"
                robot.stop()
                #robot.wait(5)
                robot.turn_angle(caminoDespejado(robot))
                return False
            elif min(tramo) < 0.15:
                print "There is something in the way!!!"
                robot.stop()
                #robot.wait(5)
                robot.turn_angle(caminoDespejado(robot))
                return False
    return True

def caminoDespejado(robot):
    if np.mean(robot.laser_range[15:17]) > np.mean(robot.laser_range[1:3]):
        return 0.001
    else:
        return -0.001

def arreglarAngulo(ang):
    #Ver si tiene que girar en 180, es mejor no girar y darle una velocidad de distancia negativa.
    #Si estan entre 90 y 270 por ejemplo. Hay que comprobar si es necesario y util
    #if ang > 90 and ang < 270:
    #if ang < 0:
    #    ang = ang*-1
    if ang > 180:
        return radians(ang - 360)
    return radians(ang)

def moverRobot(pose1,pose2,robot):
    #print pose1
    #print pose2
    #robot.wait(10)
    q1 = Quat((pose1.orientation.x,pose1.orientation.y,pose1.orientation.z,pose1.orientation.w))
    q2 = Quat((pose2.orientation.x,pose2.orientation.y,pose2.orientation.z,pose2.orientation.w))

    ang = arreglarAngulo(q2.ra - q1.ra)
    print "Angulo:",degrees(ang)
    #robot.turn_angle(ang,1)

    dist = sqrt( (pose1.position.x - pose2.position.x)**2 + (pose1.position.y - pose2.position.y)**2 )
    print "Distancia:",dist
    #robot.move_distance(dist,1.0)

    if ang == 0.0:
        ang = 0.0001

    #Ver si despues se puede variar la velocidad con respecto a algo
    robot.move_odom(dist,ang,0.05,0.05)

if __name__ == '__main__':
    try:
        robot = get_robot()
        trayectoria = get_plan()

        rospy.sleep(3)

        punto_actual = None
        trayectoria.contador_pos = 0
        guardian = True
        ida = True
        punto_guardian = 0

        while not rospy.is_shutdown():
            #print self.robot.plan[0]
            #print self.robot.plan[1]
            #print "-------------------------------------------------------"
            if len(trayectoria.camino) > 0:
                if verificarAvanzarCamino:
                    punto = trayectoria.camino.pop(0)

                    #Ver si esta es la mejor forma de guardar los puntos.
                    #Tak vez guardando puntos con posicion y orientacion es mejor?
                    robot.move_odom(punto[0],punto[1],0.05,0.05)

            else:
                print "Waiting for a Goal"

                if guardian:
                    trayectoria.guardianDCC(punto_guardian,ida)
                    punto_guardian += 1
                    #robot.wait(3)
                else:
                    trayectoria.selfPoint()
                    punto_guardian = 0

            if trayectoria.cancel_goal:
                trayectoria.cancel_goal()
                robot.stop()

            if trayectoria.self_point:
               guardian = False
               robot.stop()

            if len(trayectoria.waypoints) == 0:
                guardian = True



            """

            if guardian:
                for i in range(trayectoria.largoTrayectoria):

                    trayectoria.guardianDCC(i,ida)
                    trayectoria.contador_pos = 0
                    while True:
                        if verificarAvanzarCamino(robot):
                            if punto_actual is None:
                                robot.wait(3)
                                punto_actual = trayectoria.local_plan[trayectoria.contador_pos]
                            trayectoria.contador_pos += 1

                            moverRobot(punto_actual,trayectoria.local_plan[trayectoria.contador_pos],robot)
                            punto_actual = trayectoria.local_plan[trayectoria.contador_pos]

                        if len(trayectoria.local_plan) < 4:
                            break
                        if trayectoria.reachGoal():
                            robot.stop()
                            break
                        if trayectoria.cancel_goal:
                            robot.stop()
                            break
                        if not trayectoria.self_point:
                           #Dice que llego un goal fuera de lo guardian
                           guardian = False
                           robot.stop()
                           break

                    if not guardian:
                        break

            if not guardian:
                trayectoria.selfPoint()
                trayectoria.contador_pos = 0
                while True:
                    if verificarAvanzarCamino(robot):
                        if punto_actual is None:
                            punto_actual = trayectoria.local_plan[trayectoria.contador_pos]
                        trayectoria.contador_pos += 1

                        moverRobot(punto_actual,trayectoria.local_plan[trayectoria.contador_pos],robot)
                        punto_actual = trayectoria.local_plan[trayectoria.contador_pos]

                    if trayectoria.reachGoal():
                        robot.stop()
                        break
                    if trayectoria.cancel_goal:
                        robot.stop()
                        guardian = True
                        break
                if len(trayectoria.waypoints) == 0:
                    guardian = True
            """

    except rospy.ROSInterruptException, Exception:
        rospy.loginfo("Movimiento del robot interrumpido")
        robot.stop()
