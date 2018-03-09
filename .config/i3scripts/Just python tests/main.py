from PIL import Image



IMAGE_SRC = 'L1.png'

def showme(img):
    """ use PIL standard display """
    img.show()

def h_dist(h1, h2):
    """ distance between color hues in angular space,
    where 1.0 == 0.0 (so distance must wrap around if > 1)"""
    return min(abs(h1+1-h2), abs(h1-h2), abs(h1-1-h2))

def rgb2hls(t):
    """ convert PIL-like RGB tuple (0 .. 255) to colorsys-like
    HSL tuple (0.0 .. 1.0) """
    (r,g,b,a) = t
    r /= 255.0
    g /= 255.0
    b /= 255.0
    h,l,s = rgb_to_hls(r,g,b)
    return (h, l, s, a)

def hls2rgb(t):
    """ convert a colorsys-like HSL tuple (0.0 .. 1.0) to a
    PIL-like RGB tuple (0 .. 255) """
    (h, l, s, a) = t
    r,g,b = hls_to_rgb(*(h, l, s))
    
    r *= 255
    g *= 255
    b *= 255
    return (int(r),int(g),int(b), a)

def reload_img():
    global img, sizew, sizeh, maxsize, imgdata
    img = Image.open(IMAGE_SRC)
    sizew, sizeh = img.size
    maxsize = ((sizew/2)**2 + (sizeh/2)**2)**0.5
    imgdata = list(img.getdata())

reload_img()
for hue in range(0,4):
    for i in range(0,len(imgdata)):
        (h,l,s,a) = rgb2hls(imgdata[i])
        h = hue * 0.25
        imgdata[i] = hls2rgb((h,l,s, a))

    img.putdata(imgdata)
    showme(img)