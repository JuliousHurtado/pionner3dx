import sys
import numpy as np
import rospy

from sensor_msgs.msg import Image
from pantilt import Pantilt

import cv2
from cv2 import cv
from cv_bridge import CvBridge, CvBridgeError

class Imagen(object):

    def __init__(self):
        rospy.init_node('objetos', anonymous=True)
        rospy.myargv(argv=sys.argv)

        self.bridge = CvBridge()
        self.current_rgb_image = None
        self.current_cv_rgb_image = None
        self.current_depth_msg = None
        self.current_cv_image = None 
        self.image = None
        self.image2 = None

        self.object_center = None
        self.img_center = None

        self.__depth_img = rospy.Subscriber('/camera/depth/image_raw',Image ,self.__depth_handler)
        self.__rgb_img= rospy.Subscriber('/camera/rgb/image_raw',Image,self.__rgb_handler)

    def process_depth_image(self, img):
        mm = np.max(img)
        nn = np.min(img)

        #dst = cv2.normalize(img/mm, img, 1, 0, cv2.NORM_MINMAX)

        #print img.shape
        #dst = cv2.applyColorMap(dst, cv2.COLORMAP_RAINBOW)
        #dst = img/mm

        #dst = canny((1-img/mm))
        #fill_coins = ndi.binary_fill_holes(edges)
        #print dst.shape
        dst = (1 - (img/mm))
        #ret,dst = cv2.threshold(dst,127,255,0)
        #print np.max(dst)

        #markers = np.zeros_like(dst)
        #markers[dst < .12] = 1
        #markers[dst > .59] = 2

        #elevation_map = sobel(dst)

        #segmentation = watershed(elevation_map, markers)

        #print dst
        return dst

    def process_rgb_image(self,img):
        #blur the source image to reduce color noise 
        img = cv2.blur(img,(3,3))

        #convert the image to hsv(Hue, Saturation, Value) so its  
        #easier to determine the color to track(hue) 
        hsv_img = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

        #limit all pixels that don't match our criteria, in this case we are  
        #looking for purple but if you want you can adjust the first value in  
        #both turples which is the hue range(120,140).  OpenCV uses 0-180 as  
        #a hue range for the HSV color model 
        bajos = np.array([45,50,50], dtype=np.uint8)
        altos = np.array([90, 255, 255], dtype=np.uint8)
        thresholded_img = cv2.inRange(hsv_img, bajos, altos)

        #determine the objects moments and check that the area is large  
        #enough to be our object 
        moments = cv2.moments(thresholded_img, 0)
        area = moments['m00']
        #print moments
        #there can be noise in the video so ignore objects with small areas 
        if(area > 100000):
            #determine the x and y coordinates of the center of the object 
            #we are tracking by dividing the 1, 0 and 0, 1 moments by the area 
            x = int(moments['m10']/area)
            y = int(moments['m01']/area)

            #print 'x: ' + str(x) + ' y: ' + str(y) + ' area: ' + str(area) 
            self.object_center = [x,y]

            #create an overlay to mark the center of the tracked object 

            cv2.circle(img,(x, y), 2, (255, 255, 255), 20)
            #cv2.add(img, overlay, img)
            #add the thresholded image back to the img so we can see what was  
            #left after it was applied 
            cv2.merge(thresholded_img, img)

        #display the image  
        #cv.ShowImage(color_tracker_window, img)

        return img

    def __depth_handler(self,data):
        try:
            self.current_depth_msg = data
            self.current_cv_image = self.bridge.imgmsg_to_cv2(data, "16UC1") #32FC1

            img = np.array(self.current_cv_image, dtype=np.float).reshape(480,640)

            #max_h, max_w = img.shape
            #img = img[:max_h/2,:max_w/2]

            img = self.process_depth_image(img)
            #self.image = img
            # Display the result
            #print img
            #cv2.imshow("Depth Image", self.current_cv_image)
            
        except CvBridgeError, e:
            print e

    def __rgb_handler(self,data):
        try:
            self.current_rgb_image = data
            self.current_cv_rgb_image = np.squeeze(np.array(self.bridge.imgmsg_to_cv2(data,"bgr8")))

            img = np.asarray(self.current_cv_rgb_image)
            self.image = img

            max_h,max_w = img.shape

            self.img_center = [max_h,max_w]

            self.image2 = self.process_rgb_image(img)
            #print self.image.shape

            # Display the result
            #cv2.imshow("RGB Image", img)

        except CvBridgeError, e:
            print e

if __name__ == "__main__":
    image = Imagen()
    pantilt_obj = Pantilt('/dev/ttyUSB2',9600)
    ang_pan = 0
    ang_tilt = 0
    while True:
        if image.image is not None and image.image2 is not None:
            #cv2.imshow('Video1', image.image)
            cv2.imshow('Video2', image.image2

            if (image.img_center[0] - image.object_center[0]) > 40:
                if image.img_center[0] > image.object_center[0]:
                    ang_pan += 1.5
                else:
                    ang_pan -= 1.5
            else:
                ang_pan = 0

            if (image.img_center[1] - image.object_center[1]) > 40:
                if image.img_center[1] > image.object_center[1]:
                    ang_tilt += 3
                else:
                    ang_tilt -= 3
            else:
                ang_tilt = 0


            pantilt_obj.set_angle(ang_pan,ang_tilt)

            if cv2.waitKey(1) & 0xFF == ord('q'):
                break