require './code_generation'
load 'array_extension.rb'

person_klazz = Model.generate('person.txt')
p = Person.new
p.name = "Kalle"
p.age = 23
persons = Person.load_from_file('persons.yml')

                                

