@@mapping = [
	['e'], 
	['j', 'n', 'q'],
	['r', 'w', 'x'], 
	['d', 's', 'y'], 
	['f', 't'], 
	['a', 'm'], 
	['c', 'i', 'v'], 
	['b', 'k', 'u'], 
	['l', 'o', 'p'], 
	['g', 'h', 'z']
]

def cartprod(*args)
  result = [[]]
  while [] != args
    t, result = result, []
    b, *args = args
    t.each do |a|
      b.each do |n|
        result << a + [n]
      end
    end
  end
  result
end