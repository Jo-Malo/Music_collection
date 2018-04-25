require("pg")
require_relative("artists")
require_relative('../db/sql_runner')

class Album

  attr_reader :id, :artist_id, :name, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
    @name = options['name']
    @genre = options['genre']
  end

  def save()
    sql = "INSERT INTO albums
    (
      name,
      genre,
      artist_id
      ) VALUES
      (
        $1, $2, $3
        )
        RETURNING id"
        values = [@name, @genre, @artist_id]
        result = SqlRunner.run(sql, values)
        @id = result.first()['id'].to_i
  end

#CLASS METHODS

def self.all()
    sql = "SELECT * FROM albums"
    collections = SqlRunner.run(sql)
    collections_array = collections.map { |collection| Album.new(collection) }
    return collections_array
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result_hash = SqlRunner.run(sql, values).first()
    return Album.new(result_hash)
  end


end
