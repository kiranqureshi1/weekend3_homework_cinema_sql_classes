require_relative('../db/sql_runner.rb')


class Ticket

  attr_accessor :customer_id, :film_id, :screening_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @screening_id = options['screening_id']
  end

  def find_film
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end

  def find_customer
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customers = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  # def find_seat_limit
  #   sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.Film_id"
  #   films = SqlRunner.run(sql, values)
  #   result = films.map {|film| Film.new(film)}
  #   if result.length > films.limit_seats
  #     return "dont allow"
  #   end
  # end



  def save
    sql = "INSERT INTO tickets(customer_id, film_id) VALUES($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def list
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = "UPDATE tickets SET(customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@cutsomer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.list_all
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    return tickets.map {|ticket| Ticket.new(ticket)}
  end

  def self.delete_all
    sql = " DELETE FROM tickets"
    SqlRunner.run(sql)
  end




end #class
