e = 0
File.open('results', 'r').each_line do |line|
	line = line.strip.to_i
	if line > e
		e = line
	end
end
