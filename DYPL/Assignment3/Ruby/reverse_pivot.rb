def search(num, pivot, result)   
	return [] if pivot == 0
	if @db.key?(num[0..pivot-1])
		result += @db[num[0..pivot-1]]
		return result
	else
		pivot -= 1
		search(num, pivot, result)
	end
end