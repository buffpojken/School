f = File.new('nums', 'w+')

1000000.times do |i|
	f.puts rand(1000000000).to_s
end                                    

f.close