require('pg')
require('pry')
class Property

  attr_reader :id
  attr_accessor :address, :value, :number_of_bedrooms, :year_built

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @address = options['address']
    @value = options['value']
    @number_of_bedrooms = options['number_of_bedrooms']
    @year_built = options['year_built']
  end

  def save
    sql = "INSERT INTO properties
    (address,
      value,
      number_of_bedrooms,
      year_built)
      VALUES ($1, $2, $3, $4) RETURNING *"
      values = [@address, @value, @number_of_bedrooms, @year_built]
      db = PG.connect({dbname: 'property', host: 'localhost'})
      db.prepare("save", sql)
      result = db.exec_prepared("save", values)
      @id = result[0]['id'].to_i()
      db.close()
  end

  def update()
    sql = "UPDATE properties SET
         (address,
          value,
          number_of_bedrooms,
          year_built)  = ($1, $2, $3, $4) WHERE id = $5"
    values = [@address, @value, @number_of_bedrooms, @year_built, @id]
    db = PG.connect({dbname: 'property', host: 'localhost'})
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'property', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def Property.all()
    db = PG.connect({dbname: 'property', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    result = db.exec_prepared("all")
    db.close()
    return result.map { |property| Property.new(property) }
  end

  def Property.find(id)
    db = PG.connect({dbname: 'property', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    properties = db.exec_prepared("find", values)
    db.close()
    return properties.map { |property| Property.new(property) }
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: 'property', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = $1"
    values = [address]
    db.prepare("find_by_address", sql)
    properties = db.exec_prepared("find_by_address", values)
    db.close()
    return properties.map { |property| Property.new(property) }
  end

  def Property.delete_all()
    db = PG.connect({dbname: 'property', host: 'localhost'})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    properties = db.exec_prepared("delete_all")
    db.close()
  end

end
