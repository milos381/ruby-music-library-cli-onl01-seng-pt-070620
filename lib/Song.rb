require 'pry'
class Song

  attr_accessor :name, :artist
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist != nil #can be invoked with an optional second argument,
                                          #an Artist object to be assigned to the song's 'artist' property (song belongs to Artist)
                                          # #invokes #artist= instead of simply assigning to an @artist instance variable to ensure that associations are created upon initialization
    self.genre=(genre) if genre != nil
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(song)
    new_song = self.new(song)
    new_song.save
    new_song
  end

  def artist=(artist)
    @artist = artist        #invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
    artist.add_song(self)
  end
  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.include?(self)
  end
  def genre
    @genre

  end

  def self.find_by_name(name)
    Song.all.detect{|song| song.name == name}

  end
  def self.find_or_create_by_name(name)
    self.create(name) if Song.all.detect{|song| song.name == name} == nil

    self.find_by_name(name) if Song.all.detect{|song| song.name == name} != nil

  end
  def self.new_from_filename(filename)
    #binding.pry
    new_name_array = filename.split(" - ")
    artist_name = new_name_array[0]
    song_name = new_name_array[1]
    genre_name = new_name_array[2].split(".mp3").join

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)

  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end

end
