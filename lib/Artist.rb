
require 'pry'
class Artist

  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def self.create(artist)
    new_artist = self.new(artist)
    new_artist.save
    new_artist
  end

  def songs
    # Song.all.each do |song|
    #   song.artist == self
    # end
    @songs
  end

  def add_song(song)

    song.artist = self if song.artist == nil
    !@songs.include?(song)? self.songs << song : nil   #this song object is being added to our @songs array and stored in that array on the artist instance
    # assigns the current artist to the song's 'artist' property (song belongs to artist)
    #  does not assign the artist if the song already has an artist
    #  adds the song to the current artist's 'songs' collection
    #  does not add the song to the current artist's collection of songs if it already exists therein
  end
  def genres

    songs.map do |song|
      song.genre
    end.uniq
  end

  extend Concerns::Findable


end
