module RangedWeapons
  def attack_with_bow
    puts "#{@name} attackes with bow!"
  end
end

class Ninja
  include RangedWeapons
  def initialize(name)
      @name = name
  end
  def attack
    puts "#{@name} attacks with sword!"
  end
end

n = Ninja.new('Shinobin')
n.attack		# => prints "Shinobin attacks with sword!"
n.attack_with_bow	# => prints "Shinobin attacks with bow!"


