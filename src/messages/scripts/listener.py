#!/usr/bin/env python
import rospy
from messages.msg import Camino,Punto

def callback(data):
    rospy.loginfo(rospy.get_caller_id() + "I heard %s", data.punto)
    
def listener():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # node are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('listener', anonymous=True)

    rospy.Subscriber("chatter", Camino, callback)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    listener()


threads = list()
        t = Thread(target=server.serve_forever)
        threads.append(t)
        t.start()

def set_puntos(location):
    global puntos
    if len(puntos) < 2:
        # Puntos que lo definen como guardian
        puntos = []
        puntos.append(Pose(Point(0.985, 0.706, 0.000), Quaternion(0.000, 0.000, 0.0, 1.0)))
        puntos.append(Pose(Point(0.985, 0.706, 0.000), Quaternion(0.000, 0.000, 0.70710678, 0.70710678)))
        puntos.append(Pose(Point(0.985, 0.706, 0.000), Quaternion(0.000, 0.000, 1.0, 0.0)))
        puntos.append(Pose(Point(0.985, 0.706, 0.000), Quaternion(0.000, 0.000, 0.786, 0.618)))
        puntos.append(Pose(Point(0.985, 0.706, 0.000), Quaternion(0.000, 0.000, 0.786, 0.618)))
        puntos.append(Pose(Point(0.985, 0.706, 0.000), Quaternion(0.000, 0.000, 0.786, 0.618)))
    if location == puntos[0]:
        puntos.pop(0)
    return puntos[0]

class SingleTCPHandler(SocketServer.BaseRequestHandler):
    #"One instance per connection.  Override handle(self) to customize action."
    def handle(self):
        global puntos
        puntos = []
        # self.request is the client connection
        data = self.request.recv(1024)  # clip input at 1Kb
        #print data
        for points in data.split(";"):
            d = points.split(",")
            # Se recuperan todos los puntos, luego se hace un spline, y despues se llena puntos con
            # los puntos y angulos que encontro el spline
            #Transformar angulo a quaternion
            q = Quat((float(d[2]),0,0))
            puntos.append(Pose(Point(float(d[0]),float(d[1]),0), Quaternion(q.q[0],q.q[1],q.q[2],q.q[3])))
        #reply = pipe_command(my_unix_command, data)
        #if reply is not None:
        #self.request.send(data)
        #self.request.close()

class SimpleServer(SocketServer.ThreadingMixIn, SocketServer.TCPServer):
    # Ctrl-C will cleanly kill all spawned threads
    daemon_threads = True
    # much faster rebinding
    allow_reuse_address = True

    def __init__(self, server_address, RequestHandlerClass):
        SocketServer.TCPServer.__init__(self, server_address, RequestHandlerClass)