require_relative('../db/sql_runner')

class Transaction

  attr_reader(:date_time, :merchant_id, :tag_id, :amount, :id)

  def initialize( options )
    @id = options["id"].to_i() if options["id"]
    @date_time = options["date_time"]
    @merchant_id = options["merchant_id"].to_i
    @tag_id = options["tag_id"].to_i
    @amount = options["amount"].to_f
  end

  def save()
    sql = "INSERT INTO transactions
    (
      date_time,
      merchant_id,
      tag_id,
      amount
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@date_time, @merchant_id, @tag_id, @amount]
    results = SqlRunner.run(sql, values)
    @id = results.first()["id"].to_i
  end

  def transactions()
      sql = "SELECT tag.* FROM tags
      INNER JOIN tags
      ON tarnsaction_id = transaction.tag_id
      WHERE tag_id = $1"
      values = [@id]
      houses = SqlRunner.run(sql, values)
      return tags.map { |tag| Tag.new(tag) }
    end

  def merchant()
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [@merchant_id]
    results = SqlRunner.run( sql, values )
    return Merchant.new( results.first )
  end

  def tag()
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [@tag_id]
    results = SqlRunner.run( sql, values )
    return Tag.new( results.first )
  end


  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    return results.map { |hash| Transaction.new( hash ) }
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.find( id )
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run( sql, values )
    result = Transaction.new( transaction.first )
    return result
  end

  def self.total_trans()
    all_transactions = Transaction.all()

    running_total = 0
    for transaction in all_transactions
      running_total += transaction.amount
    end

    return running_total
  end



end
