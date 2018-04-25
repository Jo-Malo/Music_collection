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

    def self.delete_all()
      sql = "DELETE FROM artists"
      db = SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM artists"
      collections = SqlRunner.run(sql)
      collections_array = collections.map { |collection| Artist.new(collection) }
      return collections_array
    end

    def self.find(id)
      sql = "SELECT * FROM artists WHERE id = $1"
      values = [id]
      result_hash = SqlRunner.run(sql, values).first()
      return Artist.new(result_hash)
    end


  end
