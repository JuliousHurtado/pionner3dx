import sys
import serial

class Pantilt():
    
    PAN_PER_PULSE  = 0.0514
    TILT_PER_PULSE = 0.0129
    MAX_PAN_POS = 3079
    MIN_PAN_POS = -3078
    MAX_TILT_POS = 573 #2324
    MIN_TILT_POS = -852 #-3525
    MAX_PAN_VEL = 6003
    MIN_PAN_VEL = 0
    MAX_TILT_VEL = 4002
    MIN_TILT_VEL = 0
    
    
    #Initialize
    def __init__(self, port, baudrate):
        self.port = port
        self.baudrate = baudrate
        
    #Open serial port
    def open(self):
        try:
            self.ser = serial.Serial(port=self.port, baudrate=self.baudrate)
        except:
            print >> sys.stderr, 'failed to open'
            sys.exit(1)
            
    def close(self):
        self.ser.close()
            
    #Set pan-tilt angle
    def set_angle(self,pan, tilt):
        self.pan_pos = pan / self.PAN_PER_PULSE
        self.tilt_pos = tilt / self.TILT_PER_PULSE
        
        if self.pan_pos > self.MAX_PAN_POS:
            self.pan_pos = self.MAX_PAN_POS
            print 'Max pan position is 158'
        elif self.pan_pos < self.MIN_PAN_POS:
            self.pan_pos = self.MIN_PAN_POS
            print 'Min pan position is -158'
        
        if self.tilt_pos > self.MAX_TILT_POS:
            self.tilt_pos = self.MAX_TILT_POS
            print 'Max tilt position is 7.5' #30
        elif self.tilt_pos < self.MIN_TILT_POS:
            self.tilt_pos = self.MIN_TILT_POS
            print 'Min tilt position is -11' #-45
            
        print 'Pan Pos:%d Tilt Pos:%d' % (self.pan_pos, self.tilt_pos)
        
        self.ser.write('pp' + str(self.pan_pos) + '\n')
        self.ser.write('tp' + str(self.tilt_pos) + '\n')
                
    #Set pan-tilt velocity
    def set_velocity(self,pan,tilt):
        self.pan_vel = pan
        self.tilt_vel = tilt
        
        if self.pan_vel > self.MAX_PAN_VEL:
            self.pan_vel = self.MAX_PAN_VEL
            print 'Max pan velocity is %d' % (self.MAX_PAN_VEL)
        elif self.pan_vel < self.MIN_PAN_VEL:
            self.pan_vel = self.MIN_PAN_VEL
            print 'Min pan velocity is %d' % (self.MIN_PAN_VEL)
            
        if self.tilt_vel > self.MAX_TILT_VEL:
            self.tilt_vel = self.MAX_TILT_VEL
            print 'Max tilt velocity is %d' % (self.MAX_TILT_VEL)
        elif self.tilt_vel < self.MIN_TILT_VEL:
            self.tilt_vel = self.MIN_TILT_VEL
            print 'Min tilt velocity is %d' % (self.MAX_TILT_VEL)
        
        print 'Pan Vel:%d, Tilt Vel:%d' % (self.pan_vel, self.tilt_vel)
        
        self.ser.write('ps' + str(self.pan_vel) + '\n')
        self.ser.write('ts' + str(self.tilt_vel) + '\n')