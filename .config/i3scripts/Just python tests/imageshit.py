# import the necessary packages
import numpy as np
import cv2
from PIL import Image, ImageDraw

def sort(pts):

	rect = np.zeros((4, 2), dtype = "float32")
 
	s = pts.sum(axis = 1)
	rect[0] = pts[np.argmin(s)]
	rect[2] = pts[np.argmax(s)]

	diff = np.diff(pts, axis = 1)
	rect[1] = pts[np.argmin(diff)]
	rect[3] = pts[np.argmax(diff)]
 
	# return the ordered coordinates
	return rect

def four_point_transform(image, pts, bg):

	coord_sorted = sort(pts)
	(tl, tr, br, bl) = coord_sorted

	car_width, car_height = bg.size

	(height, width, channels) = image.shape

	dst = np.array([
		[0, 0],
		[width - 1, 0],
		[width - 1, height - 1],
		[0, height - 1]], dtype = "float32")
 

	M = cv2.getPerspectiveTransform(dst, coord_sorted)
	warped = cv2.warpPerspective(image, M, (car_width, car_height), dst=np.asarray(bg) ,borderMode=cv2.BORDER_TRANSPARENT)
	
	return Image.fromarray(warped)

pts = np.array([[1664, 392], [1750, 387], [1666, 438], [1753, 433]])

imagex = cv2.imread("nummerplade1.png", cv2.IMREAD_UNCHANGED)
bg = Image.open("L1.png")

warped = four_point_transform(imagex, pts, bg)


warped.show()
