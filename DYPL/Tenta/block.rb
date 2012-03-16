# Ruby

[1,2,3,4,5,6,7,8,9].filter do |item|
  local_variable = SomeObject.interesting_method(item)
  return local_variable
end

# The block will have its own lexical scope and will not leak
puts local_variable # => Will raise a MethodNotFound 