-- Lua

fact = function(x)
  if 0 == x then
    return 1
  else  
    return x * fact(x-1)
  end
end