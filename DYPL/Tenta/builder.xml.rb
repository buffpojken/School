x = Builder::XmlMarkup.new(:target => $stdout, :indent => 1)
x.instruct!
x.comment! "greetings"
x.Hello "World!"