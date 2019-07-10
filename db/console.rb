require("pry")
require_relative("../models/album")
require_relative("../models/artist")

artist1 = Artist.new({
  'name' => 'Miles Davis'})
artist1.save



album1 = Album.new({
  'title' => 'Kind of Blue',
  'genre' => 'Jazz',
  'artist_id' => artist1.id
  })


  binding.pry
  nil
