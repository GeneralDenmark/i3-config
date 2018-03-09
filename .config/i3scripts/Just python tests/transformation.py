import sys
from PIL import Image

img = Image.open("L1.png")
width, height = img.size
m = -1
xshift = abs(m) * width
new_width = width + int(round(xshift))
img = img.transform((new_width, height), Image.AFFINE,
        (1, m, -xshift if m > 0 else 0, 0, 0, 0), Image.BICUBIC)

img.show()