require_relative('../db/sql_runner.rb')


class Screening

  attr_accessor :timing
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @timing = options['timing']
  end

  def save
    sql = "INSERT INTO screenings(timing) VALUES($1) RETURNING id"
    values = [@timing]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete_all
    sql = " DELETE FROM screenings"
    SqlRunner.run(sql)
  end






end #class
