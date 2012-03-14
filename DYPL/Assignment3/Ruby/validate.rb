#!/usr/bin/env ruby
#
# Usage: validator.rb filename(s)

DICT = {"6"=>6, "k"=>7, "v"=>6, "7"=>7, "l"=>8, "a"=>5, "w"=>2, "8"=>8, "b"=>7, "m"=>5, "x"=>2, "9"=>9, "c"=>6, "y"=>3, "n"=>1, "z"=>9, "o"=>8, "d"=>3, "0"=>0, "p"=>8, "e"=>0, "1"=>1, "f"=>4, "q"=>1, "2"=>2, "g"=>9, "r"=>2, "3"=>3, "h"=>9, "s"=>3, "4"=>4, "i"=>6, "t"=>4, "5"=>5, "u"=>7, "j"=>1}

class String
  def size_without_spaces
    self.compact.length()
  end
  def compact
    self.gsub(" ","")
  end
  def to_num
    self.split("").collect { |c| DICT[c] }.join("")
  end
  def no_double_digit
    not (self.compact =~ /\d\d/)
  end
end

class Validator
  def initialize(fn)
    @errors = @cases = 0
    @cache = {}
    @fn = fn
  end

  def assert(b,msg)
    unless b
      puts msg
      @errors += 1;
    else
      yield if block_given?
    end
  end
  
  def run_tests
    f = if @fn == "<stdin>"; STDIN; else File::open(@fn, "r"); end
    while l = f.gets
      number, word = l.strip.split(": ")
      @cases += 1;
      assert(number.size() == word.size_without_spaces, "Error: length of #{number} did not match #{word} [#{@fn}] ")
      assert(number == word.to_num, "Error: #{word} could not be converted to #{number} (got #{word.to_num}) [#{@fn}]")
      assert(word.no_double_digit, "Error: #{word} contains two adjacent digits [#{@fn}]")
      assert([nil,number].include?(@cache[word.compact]), 
	     "Error: #{word} generated twice for different numbers (#{@cache[word.compact]}, #{number}) [#{@fn}]")
      assert(@cache[word.compact] == nil, 
	     "Error: #{word} generated twice for same number (#{number}) [#{@fn}]") { @cache[word.compact] = number }
    end
    f.close() unless f == STDIN;
    puts "Result: #{@errors} errors in #{@cases} cases"
  end
end

# Run program
if ARGV.size > 0 
  ARGV.each { |fn| Validator.new(fn).run_tests }
else
  Validator.new("<stdin>").run_tests
end
