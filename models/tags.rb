require_relative('../db/sql_runner')

class Tag

  attr_reader(:type, :id)

  def initialize( options )
    @id = options["id"].to_i if options['id'].to_i
    @type = options["type"]
  end

  def save()
    sql = "INSERT INTO tags
    (
      type
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@type]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def merchants
    sql = "SELECT m.* FROM merchants m INNER JOIN transactions tr ON tr.merchant_id = m.id WHERE tr.tag_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |merchant| Merchant.new(merchant) }
  end

  def self.all()
    sql = "SELECT * FROM tags"
    results = SqlRunner.run(sql)
    return results.map { |tag| Tag.new( tag ) }
  end

  def self.delete(id)
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all
    sql = "DELETE FROM tags"
    SqlRunner.run( sql )
  end

  def self.find( id )
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Tag.new( results.first )
  end

end
