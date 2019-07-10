require_relative('../db/sql_runner')
require_relative('album')

class Artist

attr_reader :id
attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

 def save()
   sql = "INSERT INTO artists (name)
         VALUES ($1)
         RETURNING id;"
   values = [@name]
   @id = SqlRunner.run(sql, values)[0]['id'].to_i
 end

 def self.delete_all()
   sql = "DELETE FROM artists"
   SqlRunner.run(sql)
 end

 def self.all()
   sql = "SELECT * FROM artists"
   artist_list = SqlRunner.run(sql)
   return artist_list.map { |artist| Artist.new(artist) }
 end

  def albums()
    sql = "SELECT * FROM albums
    WHERE artist_id = $1;"
    values = [@id]
    album_hashes = SqlRunner.run(sql, values)
    return album_hashes.map { |album| Album.new(album)}
  end

  def update()
    sql = "UPDATE artists
    SET name = $1
    WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists
    WHERE name = $1;"
    values = [@name]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT FROM artists
    WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    artists_hash = results.first
    artiste = Artist.new(artists_hash)
    return artiste
  end

end
