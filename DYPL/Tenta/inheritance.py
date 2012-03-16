class RangedNinja():
  def attack_with_bow(self):
    print self.name + " attacks with bow!"

class Ninja(RangedNinja):
  def __init__(self, name):
    self.name = name
  def attack(self):
    print self.name + " attacks with sword!"

n = Ninja("Shinobin")
n.attack()                # => prints "Shinobin attacks with sword!"
n.attack_with_bow()       # => prints "Shinobin attacks with bow!"
