require './code_generation'

person_klazz = Model.generate('person.txt')
puts Person.inspect
p = Person.new
p.name = "Kalle"
p.age = 23
