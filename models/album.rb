require_relative('../db/sql_runner')
require_relative('artist')

class Album

attr_reader :artist_id, :title, :genre, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id)
          VALUES ($1, $2, $3)
          RETURNING id;"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['album_id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    album_list = SqlRunner.run(sql)
    return album_list.map { |album| Album.new(album) }
  end

  def artist()
    sql = "SELECT * FROM artists
    WHERE id = $1;"
    values = [@artist_id]
    return Artist.new (SqlRunner.run(sql, values).first)
  end

  def update()
    sql = "UPDATE albums
    SET (title, genre, artist_id) = ($1, $2, $3)
    WHERE id = $4;"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums
    WHERE title = $1;"
    values = [@title]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums
    WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    albums_hash = results.first
    record = Album.new(albums_hash)
    return record
  end

  end
