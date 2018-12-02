require_relative("../db/sql_runner")

class Customer

  attr_reader :id

  attr_accessor :name, :funds

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save
    sql = "INSERT INTO customers(name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def update
    sql = "UPDATE customers SET (name, funds)
        = ($1, $2) WHERE id = $3"
    values = [@name,@funds,@id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def film()
  sql = "SELECT films.*
          FROM films INNER JOIN tickets
          ON films.id = tickets.film_id
          WHERE tickets.customer_id = $1"
  values = [@id]
  film_arry = SqlRunner.run(sql, values)
  films = film_arry.map {|film_hash| Film.new(film_hash)}
  return films
  end

  def reduce_funds(price)
    @funds -= (price)
    sql = "UPDATE customers SET (name, funds)
        = ($1, $2) WHERE id = $3"
    values = [@name,@funds,@id]
    SqlRunner.run(sql, values)
  end

  def tickets_bought()
  sql = "SELECT films.*
          FROM films INNER JOIN tickets
          ON films.id = tickets.film_id
          WHERE tickets.customer_id = $1"
  values = [@id]
  film_arry = SqlRunner.run(sql, values)
  films = film_arry.count {|film_hash| Film.new(film_hash)}
  return films
  end


end
