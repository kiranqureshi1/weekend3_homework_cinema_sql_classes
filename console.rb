require('pry-byebug')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')


Customer.delete_all()
Film.delete_all()
Ticket.delete_all()
Screening.delete_all()

customer_1 = Customer.new({'name' => 'Kira', 'funds' => 100})
customer_2 = Customer.new({'name' => 'Jojo', 'funds' => 200})
customer_3 = Customer.new({'name' => 'Mina', 'funds' => 300})
customer_4 = Customer.new({'name' => 'Paul', 'funds' => 400})

customer_1.save()
customer_2.save()
customer_3.save()

customer_1.list()

customer_4.name = 'Richard'
customer_4.update()


customer_4.delete()

customers = Customer.list_all()


film_1 = Film.new({'title' => 'life', 'price' => 10, 'limit_seats' => 3})
film_2 = Film.new({'title' => 'love', 'price' => 20, 'limit_seats' => 4})
film_3 = Film.new({'title' => 'happiness', 'price' => 30, 'limit_seats' => 4})
film_4 = Film.new({'title' => 'happy', 'price' => 30, 'limit_seats' => 5})

film_1.save()
film_2.save()
film_3.save()

film_4.title = 'hurray'
film_4.update()

film_4.delete()

films = Film.list_all()






screening_1 = Screening.new({'timing' => 10})
screening_2 = Screening.new({'timing' => 11})

screening_1.save()
screening_2.save()



ticket_1 = Ticket.new({'customer_id' => customer_3.id, 'film_id' => film_1.id, 'screening_id' => screening_1.id})
ticket_2 = Ticket.new({'customer_id' => customer_2.id, 'film_id' => film_2.id, 'screening_id' => screening_1.id})
ticket_3 = Ticket.new({'customer_id' => customer_1.id, 'film_id' => film_1.id, 'screening_id' => screening_1.id})
ticket_4 = Ticket.new({'customer_id' => customer_1.id, 'film_id' => film_2.id, 'screening_id' => screening_2.id})
ticket_5 = Ticket.new({'customer_id' => customer_2.id, 'film_id' => film_2.id, 'screening_id' => screening_2.id})

ticket_1.save()
ticket_2.save()
ticket_3.save()
ticket_4.save()

ticket_5.customer_id = customer_1.id
ticket_5.update()

ticket_5.delete()

tickets = Ticket.list_all()












binding.pry
nil
