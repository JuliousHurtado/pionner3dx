import rospy
from math import pow, sqrt, atan, degrees,radians, pi
import tf
from Quaternion import Quat

from pyturtlebot import get_robot
from trayectoria import get_plan

import numpy as np

import time

"""
func verificarAvanzarCamino(robot):
params
    robot: es la clase encargada de todo lo que es el robot, moviemiento y laser.
def
    Esta encargada de verificar si se puede avanzar. Divide los 18 puntos del laser en en 4 tramos.
    El primer tramo es lo que se ve directamente de frente (8,9,10,11), luego los de los costados pero
    que sigue influyendo en el camino (6,7,12,13). El tercer tramo que puede causar colisiones es el 
    de (3,4,5,14,15). Los que sobran no deberia causar colisiones.
    En caso de que no pueda avanzar, comienza a girar para poder encontrar otro camino local.
return
    Devuelve True en caso de que se pueda avanzar y False en caso de que no.
"""
def verificarAvanzarCamino(robot,trayectoria = None):
    for i in range(robot.max_seg-1):
        tramo = robot.laser_range[robot.grados_sep*i:robot.grados_sep*(i+1)]
        #Verificar estos valores
        if i > 2 and i < 16:
            if i in [8,9,10,11] and min(tramo) < 0.3:
                print "There is something in the way!!!"
                robot.stop()
                trayectoria.renovarCamino()
                #robot.wait(5)
                robot.turn_angle(caminoDespejado(robot))
                return False
            if i in [6,7,12,13] and min(tramo) < 0.2:
                print "There is something in the way!!!"
                robot.stop()
                trayectoria.renovarCamino()
                #robot.wait(5)
                robot.turn_angle(caminoDespejado(robot))
                return False
            elif min(tramo) < 0.15:
                print "There is something in the way!!!"
                robot.stop()
                trayectoria.renovarCamino()
                #robot.wait(5)
                robot.turn_angle(caminoDespejado(robot))
                return False
    return True

"""
func caminoDespejado(robot):
params
    robot: es la clase encargada de todo lo que es el robot, moviemiento y laser.
def
    Busca en que direccion esta mas despejado para un posible camino sin colisiones.
    Esto se hace despues de encontrar que el camino presenta obstaculos y se tiene que 
    buscar alternativas. Esto es girar hacia la derecha o la izquierda.
return
    Retorna el angulo y la velocidad
"""
def caminoDespejado(robot):
    if np.mean(robot.laser_range[15:17]) > np.mean(robot.laser_range[1:3]):
        return 0.001,0.3
    else:
        return -0.001,0.3

"""
func arreglarAngulo(ang):
parans
    ang: Es un flotante
def 
    Encargada de que el robot no gire mas de 180 grados, si se tiene mas grados de separacion
    es mejor que gira hacia el otro lado.
return
    El angulo nuevo en radianes
"""
def arreglarAngulo(ang):
    #Ver si tiene que girar en 180, es mejor no girar y darle una velocidad de distancia negativa.
    #Si estan entre 90 y 270 por ejemplo. Hay que comprobar si es necesario y util
    #if ang > 90 and ang < 270:
    #if ang < 0:
    #    ang = ang*-1
    if ang > 180:
        return radians(ang - 360)
    return radians(ang)

"""
func moverRobot(pose1,pose2,robot):
params
    pose1: Es la posicion actual del robot, con coordenadas y orientacion
    pose2: Es la posicion que se queire llegar
    robot: es la clase encargada de todo lo que es el robot, moviemiento y laser.
"""
def moverRobot(trayectoria, pose1,pose2,robot, x1 = 0, y1 = 0, ang1 = 0):
    #print pose1
    #print pose2
    #robot.wait(10)
    if pose1 is None:
        q2 = Quat((pose2.orientation.x,pose2.orientation.y,pose2.orientation.z,pose2.orientation.w))
        ang = arreglarAngulo(q2.ra - ang1.ra)

        dist = sqrt( (x1 - pose2.position.x)**2 + (y1 - pose2.position.y)**2 )

    else:
        q1 = Quat((pose1.orientation.x,pose1.orientation.y,pose1.orientation.z,pose1.orientation.w))
        q2 = Quat((pose2.orientation.x,pose2.orientation.y,pose2.orientation.z,pose2.orientation.w))

        ang = arreglarAngulo(q2.ra - q1.ra)
        dist = sqrt( (pose1.position.x - pose2.position.x)**2 + (pose1.position.y - pose2.position.y)**2 )

    print "Angulo:",ang
    #robot.turn_angle(ang,1)
    print "Distancia:",dist
    #robot.move_distance(dist,1.0)

    ang_negativo = False
    if ang < 0:
        ang_negativo = True
        ang = ang*-1

    #Ver si despues se puede variar la velocidad con respecto a algo
    sum_dist = 0
    sum_ang = 0
    cant_dist = 0.01
    cant_ang = 0.01
    
    if ang != 0:
        cant_ite = int(abs(ang/cant_ang))
        if cant_ite != 0:
            cant_dist = float(dist/cant_ite)
        else:
            cant_dist = 0.01
    else:
        cant_dist = 0.01

    while sum_dist < dist or sum_ang < ang:
        if dist <= sum_dist:
            cant_dist = 0.0
        if ang <= sum_ang:
            cant_ang = 0.0

        if verificarAvanzarCamino(robot,trayectoria):
            if ang_negativo:
                robot.move_odom(cant_dist,cant_ang*-1,0.05,0.2)
            else:
                robot.move_odom(cant_dist,cant_ang,0.05,0.2)

        #print "Angulo: ", ang
        #print "Recorrido Angulo: ",sum_ang 
        #print "Distancia: ", dist
        #print "Recorrido Distancia: ",sum_dist

        sum_dist += cant_dist + cant_dist*0.3
        sum_ang += cant_ang + cant_ang*0.3

    robot.stop()

def agregarGoal(guardian,punto_guardian,trayectoria,ida):
    if guardian:
        trayectoria.guardianDCC(punto_guardian,ida)
        punto_guardian += 1
    else:
        trayectoria.selfPoint()
        punto_guardian = 0

    return punto_guardian

if __name__ == '__main__':
    rospy.init_node('pioneer', anonymous=True)
    try:
        robot = get_robot()
        trayectoria = get_plan()

        trayectoria.cancel_goal_func()
        trayectoria.camino = []

        time.sleep(5)

        guardian = True
        ida = True
        punto_guardian = 0

        while not rospy.is_shutdown():
            #print self.robot.plan[0]
            #print self.robot.plan[1]
            #print "-------------------------------------------------------"
            if len(trayectoria.camino) > 1:
                print "Largo del camino: ",len(trayectoria.camino)

                if len(trayectoria.camino) < 5:
                    #Girar en direccion al goal
                    #esperando que se arme un camino local mas largo.
                    ang_to_goal = arreglarAngulo(trayectoria.goalDireccition())
                    robot.turn_angle(ang_to_goal)

                if verificarAvanzarCamino(robot,trayectoria):
                    if trayectoria.x_act is None:
                        punto = trayectoria.camino.pop(0)
                        moverRobot(trayectoria, punto,trayectoria.camino[0],robot)
                        punto = trayectoria.camino[0]
                        trayectoria.x_act = punto.position.x
                        trayectoria.y_act = punto.position.y
                        trayectoria.ang_act = Quat((punto.orientation.x,punto.orientation.y,punto.orientation.z,punto.orientation.w))
                    else:
                        punto = trayectoria.camino.pop(0)
                        moverRobot(trayectoria, None,punto,robot, trayectoria.x_act, trayectoria.y_act, trayectoria.ang_act)
                        trayectoria.x_act = punto.position.x
                        trayectoria.y_act = punto.position.y
                        trayectoria.ang_act = Quat((punto.orientation.x,punto.orientation.y,punto.orientation.z,punto.orientation.w))

                if trayectoria.reachGoalCamino():
                    punto_guardian = agregarGoal(guardian,punto_guardian,trayectoria,ida)
                    time.sleep(5)

            else:
                print "Waiting for a Goal"
                punto_guardian = agregarGoal(guardian,punto_guardian,trayectoria,ida)
                time.sleep(5)

            if trayectoria.cancel_goal:
                trayectoria.cancel_goal_func()
                robot.stop()

            if trayectoria.self_point:
               guardian = False
               #Quizas reiniciar el camino
               robot.stop()

            if trayectoria.reachGoal():
                punto_guardian = agregarGoal(guardian,punto_guardian,trayectoria,ida)

            if len(trayectoria.waypoints) == 0:
                guardian = True

            if punto_guardian == (len(trayectoria.x_guard) - 1):
                if ida:
                    ida = False
                else:
                    ida = True


    except rospy.ROSInterruptException, Exception:
        rospy.loginfo("Movimiento del robot interrumpido")
        robot.stop()
