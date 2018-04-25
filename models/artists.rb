require("pg")
require_relative('../db/sql_runner')
require_relative("albums")

class Artist

  attr_reader :id, :name

  def initialize(options)
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists
    (
      name
      ) VALUES
      (
        $1
        )
        RETURNING id"
        values = [@name]
        result = SqlRunner.run(sql, values)
        @id = result.first()['id'].to_i
  end

  #CLASS METHODS

  def self.all()
      sql = "SELECT * FROM artists"
      collections = SqlRunner.run(sql)
      collections_array = collections.map { |collection| Artist.new(collection) }
      return collections_array
    end

  



end
