from pantilt import Pantilt
import time

pantilt = Pantilt('/dev/ttyUSB2',9600) #Change port and baudrate
pantilt.open()

# Maximo del tilt (cabeza de arriba) es de +7.5,-11
#Se mueve a la posicion indicada, es decir si se coloca 0, se mueve a la posicion 0 grados
# No es que gire los grados indicados
#pantilt.set_angle(0,0)
#time.sleep(2)

pantilt.set_angle(20,0)
time.sleep(2)

pantilt.set_angle(0,0)
time.sleep(2)

pantilt.close()
