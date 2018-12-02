require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

require('pry-byebug')
Ticket.delete_all
Film.delete_all
Customer.delete_all

customer1 = Customer.new({ 'name' => "Scott", 'funds' => "100"})
customer1.save
customer2 = Customer.new({ 'name' => "Mark", 'funds' => "50"})
customer2.save
customer3 = Customer.new({ 'name' => "Amy", 'funds' => "60"})
customer3.save

customer3.funds = 70
customer3.update
customer2.delete

film1 = Film.new({ 'title' => "The Shining", 'price' => "5"})
film1.save
film2 = Film.new({ 'title' => "Spider_Man Spiderverse", 'price' => "8"})
film2.save
film3 = Film.new({ 'title' => "Mortal Engines", 'price' => "8"})
film3.save
film4 = Film.new({ 'title' => "Battlefield Earth", 'price' => "2"})
film4.save

film3.price = 9
film3.update
film4.delete

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket3.save
ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket4.save
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket5.save

ticket3.delete

customer1.funds = 90
customer1.update
film2.price = 9
film2.update
ticket1.customer_id = customer3.id
ticket1.update
customer3.reduce_funds(film2.price)




binding.pry
nil
