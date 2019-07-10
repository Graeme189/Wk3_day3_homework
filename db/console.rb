require("pry")
require_relative("../models/album")
require_relative("../models/artist")

Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  'name' => 'Miles Davis'})
artist1.save

album1 = Album.new({
  'title' => 'Kind of Blue',
  'genre' => 'Jazz',
  'artist_id' => artist1.id
  })
album1.save

  binding.pry
  nil
