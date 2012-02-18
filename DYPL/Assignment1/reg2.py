import re
class SyntaxParser:
  """Parsing Turtlesyntax"""
  def __init__(self):     
    pass       
  def setEngine(self, engine):
    self.engine = engine
  def pen(self, code):
    if re.search('up', code):
      return "engine.pen_up()"
    else:
      return "engine.pen_down()"
  def move(self, code):
    if re.search('forward', code):
      return "engine.move_forward()"      
    elif re.search('backward', code):
      return "engine.move_backward()"      
    else:                                                           
      _g = re.search("\(([A-Za-z\d\*\-+/]+),\s?([A-Za-z\d\*\-+/]+)\)", code)                         
      return "engine.move("+_g.group(1)+","+_g.group(2)+")"
  def turn(self, code):
    _g = re.search("turn\s(cw|ccw)\(([\dA-Za-z*\-/+]+)\)", code)    
    return "engine.turn_"+_g.group(1)+"("+_g.group(2)+")"
  def put(self, code):
    _g = re.search("\(([A-Za-z\d\*\-+/]+),\s?([A-Za-z\d\*\-+/]+),\s?([A-Za-z\d\*\-+/]+)\)", code)    
    return "engine.put("+_g.group(1)+","+_g.group(2)+","+_g.group(3)+")"
  def _for(self, code):
    code = code.split("\n")          
    args = re.search("for\s([A-Za-z]+)\s?=\s?([\d]+)\sto\s([\d]+)", code[0])                             
    cmd = "for "+args.group(1).strip()+" in range("+args.group(2)+", "+args.group(3)+"):\n"+self.parse("\n".join(code[1:-1]),2)
    return cmd
  def parse(self, code, indent=0):
    code = code.split("\n")       
    tree = {'pen':self.pen, 'move':self.move, 'turn':self.turn, 'put':self.put}
    glob_stack = ""
    stack = ""                              
    for cmd in code:               
      for leaf in tree.keys():   
        if re.search(leaf, cmd): 
          if stack != "":
            stack += cmd + "\n"
          else:         
            glob_stack += (indent*" ")+tree[leaf](cmd) + "\n"            
        elif re.search('for ', cmd):
          stack = cmd+"\n"
        elif re.search('end', cmd):       
          if stack != "":
            cmd2 = stack + cmd
            glob_stack += self._for(cmd2) + "\n"
          stack = ""
    return glob_stack                               