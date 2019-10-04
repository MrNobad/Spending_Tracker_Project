require_relative('..db/sql_runner')

class Transaction

  atttr_reader(:merchant_id, :tag_id, :id)

  def initialize( options )
    @id = options["id"].to_i if options["id"]
    @merchant_id = options["merchant_id"].to_i
    @tag_id = options["tag_id"].to_i
  end

  def save()
    sql = "INSERT INTO transactions
(
  merchant_id,
  tag_id
)
VALUES
(
  $1, $2
)
    RETURNING id"
    values = [@merchant_id, @tag_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()["id"].to_i
  end

def self.all()
  sql = "SELECT * FROM transactions"
  results = SqlRunner.run(sql)
  return results.map { |transaction| Transaction.new( hash ) }
end

def self.delete_all()
sql = "DELETE FROM transactions"
SqlRunner.run(sql)
end
