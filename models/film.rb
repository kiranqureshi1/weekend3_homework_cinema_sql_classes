require_relative('../db/sql_runner.rb')


class Film

  attr_accessor :title, :price, :limit_seats
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
    @limit_seats = options['limit_seats']
  end

  def customers_watched_particular_film
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE tickets.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map {|customer| Customer.new(customer)}
  end

  def number_of_customers_watched_particular_film
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE tickets.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    result = customers.map {|customer| Customer.new(customer)}
    return result.length
  end

  def popular_time_to_watch_film
    sql = "SELECT screenings.timing FROM screenings INNER JOIN tickets ON tickets.screening_id = screenings.id WHERE tickets.film_id = $1"
    values = [@id]
    screenings = SqlRunner.run(sql, values)
    return screenings.map {|screening| Screening.new(screening)}
  end


  def save
    sql = "INSERT INTO films(title, price, limit_seats) VALUES($1, $2, $3) RETURNING id"
    values = [@title, @price, @limit_seats]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def list
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = "UPDATE films SET(title, price, limit_seats) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @price, @limit_seats, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.list_all
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    return films.map {|film| Film.new(film)}
  end

  def self.delete_all
    sql = " DELETE FROM films"
    SqlRunner.run(sql)
  end



end
