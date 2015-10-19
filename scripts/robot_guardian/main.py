#!/usr/bin/env python

from math import sqrt, atan, degrees,radians, pi
from Quaternion import Quat
from threading import Thread
import time

from trayectoria import get_moving
from pyturtlebot import get_robot

import rospy
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
import actionlib
from actionlib_msgs.msg import *
from geometry_msgs.msg import Pose, PoseWithCovarianceStamped, Point, Quaternion, Twist


def findOrientation(pose1,pose2):

    ang_pos_final = degrees(atan(float(abs(pose2.position.y-pose1.position.y))/float(abs(pose2.position.x-pose1.position.x))))

    #if pose2.position.x < pose1.position.x:
    #    ang_pos_final = ang_pos_final*-1

    q = Quat((ang_pos_final,0,0))

    return q

def agregarGoal(punto_guardian,trayectoria,ida):
    pose = None
    if trayectoria.guardian:
        if ida:
            aux1 = punto_guardian
            aux2 = punto_guardian + 1
            punto_guardian += 1
        else:
            aux1 = punto_guardian
            aux2 = punto_guardian - 1
            punto_guardian -= 1

        pose1 = trayectoria.poses_guardian[aux1]
        pose2 = trayectoria.poses_guardian[aux2]

        q = findOrientation(pose1,pose2)
        pose = Pose(Point(pose1.position.x,pose1.position.y,pose1.position.z), Quaternion(q.q[0], q.q[1], q.q[2], q.q[3]))
        pose = None 
    else:
        pose = trayectoria.selfPoint()
        punto_guardian = 0

    print pose
    trayectoria.setGoal(pose)
    return punto_guardian

def move():
    #what to do if shut down (e.g. ctrl + C or failure)
    trayectoria = get_moving()
    robot = get_robot()
    rospy.on_shutdown(trayectoria.shutdown)

    ida = True
    punto_guardian = 0

    while not rospy.is_shutdown():
        if trayectoria.goal_bool:
            for i in range(10): #200
                cont = 1
                success = trayectoria.move_base.wait_for_result(rospy.Duration(cont))
                #robot.wait(1)

                #Verificar si esta cerca y en linea recta, para que se ponga otro goal y se avance "manual"
                diff_x,diff_y,diff_ang = trayectoria.checkProximityGoal()

                if diff_x < 0.3 and diff_y < 0.3:
                    t1 = Thread(target=robot.moveManualRobot(diff_x,diff_y,diff_ang)) #ang_pan_tilt[0],ang_pan_tilt[1]
                    t1.start()
                    time.sleep(2)
                    break

                #if trayectoria.interrumpir:
                #    trayectoria.interrumpir = False
                #    break
                #Comentado porque caminos envia constantemente puntos y se interrumpe mucho.
                #Ver si hay alguna forma de que caminos no envie tanto
                #Por el momento llega hasta el goal para despues buscar otro goal
                #No se si para en algun momento de tratar de detectar a la persona

                if success:
                    print "break"
                    break

            if not success:
                trayectoria.move_base.cancel_goal()
                rospy.loginfo("The base failed to reach the desired pose")
            else:
                # We made it!
                state = trayectoria.move_base.get_state()
                if state == GoalStatus.SUCCEEDED:
                    rospy.loginfo("Hooray, reached the desired pose")

            trayectoria.move_base.cancel_goal()
            trayectoria.goal_bool = False

        else:
            punto_guardian = agregarGoal(punto_guardian,trayectoria,ida)

        if punto_guardian == (len(trayectoria.poses_guardian) - 1):
            ida = False
        elif punto_guardian == 0:
            ida = True



if __name__ == '__main__':
    try:
        move()
    except rospy.ROSInterruptException:
        rospy.loginfo("Exception thrown")