from JythonTranslater import Jtrans       
from reg2 import SyntaxParser
import math    
import sys
class Turtle(Jtrans):
  def __init__(self, parser):
    self.angle    = 0
    self.drawing  = True
    self.pos      = 0,0  
    self.parser   = parser
    parser.setEngine(self)
    pass
  def pen_up(self):
    self.drawing = False
  def pen_down(self):
    self.drawing = True
  def put(self,x,y,a):
    self.pos = x,y       
    self.angle = (a % 360)
  def turn_cw(self, a):  
    self.setAngle(a)
  def turn_ccw(self,a):
    self.setAngle(-a)
  def move_backward(self):
    self.move(1, 180)
  def move_forward(self):
    self.move(1, 0)
  def move(self,s,a):              
    self.setAngle(a)             
    ca = self.coord(self.pos, s, self.angle)
    queue = self.line(self.pos, ca)
    for c in queue:
      self.draw(int(math.floor(c[0])), int(math.floor(c[1])))
    self.pos = ca
  def setAngle(self, a):
    self.angle = (self.angle + a) % 360
  def draw(self,x,y):             
    if self.drawing:
      self.dypl.setPixel(x,y)
  def coord(self, (x,y), s, a):
    # Use Pythagoras to determine end-coords for 
    # the provided data
    # REFACTOR THIS            
    if a >= 0 and a <= 90:    
      quad = 1
      a = 90 - a
    elif a > 90 and a <= 180:
      quad = 2
      a = 180 - a
    elif a > 180 and a <= 270:
      quad = 3      
      a = 270 - a
    elif a > 270 and a <= 360:
      quad = 4      
      a = 360 - a
    unknown_angle = 180 - (a + 90)  
    length_of_bottom = (s * math.sin(math.radians(unknown_angle)))/math.sin(math.radians(90))
    height_of_leg = (s * math.sin(math.radians(a)))/math.sin(math.radians(90))
    if quad == 1:
      return (x+length_of_bottom, y-height_of_leg)
    elif quad == 2:
      return (x+height_of_leg, y+length_of_bottom)
    elif quad == 3:
      return (x-length_of_bottom, y+height_of_leg)
    elif quad == 4:
      return (x-height_of_leg, y-length_of_bottom)
    else: 
      print "Are you living in a world where a circle doesn't have 360 degs?"    
  def line(self, (x,y),(x2,y2)):
    # Use simple Bresenham to calculate coordinates for 
    # the line between two arbitrary points (this ensures)
    # smooth rendering
    steep = 0
    coords = []
    dx = abs(x2 - x)
    if (x2 - x) > 0: sx = 1
    else: sx = -1
    dy = abs(y2 - y)
    if (y2 - y) > 0: sy = 1
    else: sy = -1
    if dy > dx:
       steep = 1
       x,y = y,x
       dx,dy = dy,dx
       sx,sy = sy,sx
    d = (2 * dy) - dx
    for i in range(0,dx):
        if steep: coords.append((y,x))
        else: coords.append((x,y))
        while d >= 0:
            y = y + sy
            d = d - (2 * dx)
        x = x + sx
        d = d + (2 * dy)
    coords.append((x2,y2))
    return coords     
    
  def actionPerformed(self, event):        
    code = self.parser.parse(self.dypl.getCode())   
    cm = compile(code, '<string>', 'exec')
    eval(cm, globals(), {"engine":self})
  def setDYPL( self, obj ):
    print("Got a DYPL instance: ")
    self.dypl = obj; 
    print(obj)
if __name__ == '__main__':
    import DYPL     
    print sys.version
    turtle = Turtle(SyntaxParser())
    DYPL(turtle)
    
