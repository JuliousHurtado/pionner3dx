#! /usr/bin/env python
import SocketServer, subprocess, sys
from threading import Thread
import time

my_unix_command = ['bc']
HOST = 'localhost'
PORT = 2010
puntos = None

def pipe_command(arg_list, standard_input=False):
    #"arg_list is [command, arg1, ...], standard_input is string"
    pipe = subprocess.PIPE if standard_input else None
    subp = subprocess.Popen(arg_list, stdin=pipe, stdout=subprocess.PIPE)
    if not standard_input:
        return subp.communicate()[0]
    return subp.communicate(standard_input)[0]

class SingleTCPHandler(SocketServer.BaseRequestHandler):
    #"One instance per connection.  Override handle(self) to customize action."
    def handle(self):
        global puntos
        # self.request is the client connection
        data = self.request.recv(1024)  # clip input at 1Kb
        #print data
        puntos = data
        #reply = pipe_command(my_unix_command, data)
        #if reply is not None:
        self.request.send(data)
        self.request.close()

class SimpleServer(SocketServer.ThreadingMixIn, SocketServer.TCPServer):
    # Ctrl-C will cleanly kill all spawned threads
    daemon_threads = True
    # much faster rebinding
    allow_reuse_address = True

    def __init__(self, server_address, RequestHandlerClass):
        SocketServer.TCPServer.__init__(self, server_address, RequestHandlerClass)

def prueba():
    print "Hola1"

    while True:
        print "Hola2"

if __name__ == "__main__":
    server = SimpleServer((HOST, PORT), SingleTCPHandler)
    # terminate with Ctrl-C
    try:

        threads = list()

        t = Thread(target=server.serve_forever)
        threads.append(t)
        t.start()

        #server.serve_forever()

        print "Hola1"

        while True:
            print "Hola2"
            print puntos

            time.sleep(5)

    except KeyboardInterrupt:
        sys.exit(0)