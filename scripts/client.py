import socket
def client(string):
    HOST, PORT = 'localhost', 2011
    # SOCK_STREAM == a TCP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    #sock.setblocking(0)  # optional non-blocking
    sock.connect((HOST, PORT))
    sock.send(string)
    reply = sock.recv(16384)  # limit reply to 16K
    sock.close()
    return reply

#assert client('2+2') == '4'

print client("-0.612,-0.692,60;0.985,0.706,0")