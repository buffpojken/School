require './array_extension'

a = [1,2,3,4,5]

puts a.select_first(:magnitude => [1,4])
puts a.select_first(:name => :magnitude, :interval => {:min => 2, :max => 4}).inspect
puts a.select_all(:name => :magnitude, :interval => {:min => 2, :max => 4}).inspect

puts a.select_first_where_magnitude_is(3)
puts a.select_first_where_magnitude_is([2,3])
puts a.select_all_where_magnitude_is_in(3,4).inspect
