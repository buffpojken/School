f = File.new('nums', 'w+')

2000000.times do |i|
	f.puts rand(1000000000000)
end                                    

f.close