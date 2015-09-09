#!/usr/bin/env python
# license removed for brevity
import rospy
from messages.msg import Camino,Punto

def talker():
    pub = rospy.Publisher('chatter', Camino, queue_size=10)
    rospy.init_node('talker', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    #while not rospy.is_shutdown():
    hello_str = "hello world %s" % rospy.get_time()
    numero = Camino()
    punto = Punto()
    punto.x = 1
    punto.y = 4
    punto.angulo = 7
    punto.tiempo = 1
    numero.punto.append(punto)
    punto.x = 1
    punto.y = 4
    punto.angulo = 7
    punto.tiempo = 1
    numero.punto.append(punto)
    rospy.loginfo(numero)
    pub.publish(numero)
    #rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass