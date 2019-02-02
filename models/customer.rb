require_relative('../db/sql_runner.rb')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def films
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map {|film| Film.new(film)}
  end

  def total_number_of_tickets_bought
    sql = "SELECT tickets.* FROM tickets INNER JOIN customers ON customers.id = tickets.customer_id WHERE customers.id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    result = tickets.map {|ticket| Ticket.new(ticket)}
    return result.length
  end



  # def funds_after_ticket_bought(films)
  #   @funds -= films.price
  # end


  def save
    sql = "INSERT INTO customers(name, funds) VALUES($1, $2) RETURNING id"
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end


  def list
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = "UPDATE customers SET(name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.list_all
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    return customers.map {|customer| Customer.new(customer)}
  end

  def self.delete_all
    sql = " DELETE FROM customers"
    SqlRunner.run(sql)
  end



end
