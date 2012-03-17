class Ninja
  def initialize(name);@name = name;end
end
ninja = Ninja.new("Shinobin")
puts ninja / 2 
# => Will throw a NoMethodError, since the type Ninja is 
# not compatible with division operations
class Ninja
  def /(args)
    return @name.length / args
  end
end

puts ninja / 2 
# => prints 4, since type Ninja now supports
# division operations