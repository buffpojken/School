def block_method(&block)
    yield 'ninja'
end

block_method do |ninja_string|
  puts "Yield:#{ninja_string}"	     
end