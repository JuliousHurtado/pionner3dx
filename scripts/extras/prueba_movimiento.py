import rospy
from math import pow, sqrt, atan, degrees,radians, pi

from pyturtlebot import get_robot
from trayectoria import get_plan

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
        return 0.001,0.3
    else:
        return -0.001,0.3

if __name__ == '__main__':
    rospy.init_node('pioneer', anonymous=True)
    try:
        robot = get_robot()
        #rayectoria = get_plan()

        rospy.sleep(2)

        sum_dist = 0
        sum_ang = 0
        cant_dist = 0.01
        cant_ang = 0.01
        dist = 0.003
        ang = radians(5)

        ang_negativo = False
        if ang < 0:
            ang_negativo = True
            ang = ang*-1

        #robot.move_odom(0,radians(90),0.5,0.5)

        if ang != 0:
            cant_ite = int(ang/cant_ang)
            cant_dist = float(dist/cant_ite)
        else:
            cant_dist = 0.01

        while sum_dist < dist or sum_ang < ang:
            if dist <= sum_dist:
                cant_dist = 0.0
            if ang <= sum_ang:
                cant_ang = 0.0

            if verificarAvanzarCamino(robot):
                if ang_negativo:
                    robot.move_odom(cant_dist,cant_ang*-1,0.05,0.2)
                else:
                    robot.move_odom(cant_dist,cant_ang,0.05,0.2)

            print "Angulo: ", ang
            print "Recorrido Angulo: ",sum_ang 
            print "Distancia: ", dist
            print "Recorrido Distancia: ",sum_dist

            sum_dist += cant_dist + cant_dist*0.3
            sum_ang += cant_ang + cant_ang*0.3
        
        robot.stop()
        print "Termine"

    except rospy.ROSInterruptException, Exception:
        rospy.loginfo("Movimiento del robot interrumpido")
        robot.stop()
    robot.stop()
