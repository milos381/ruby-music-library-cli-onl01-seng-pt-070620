class MusicLibraryController
  attr_accessor :path
  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end
  def call
    input = gets.strip
    if input != exit
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list by artist'."
    puts "To list all of the songs of a particular genre, enter 'list by genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    if input == "list songs"
      list_songs
    elsif input == "list artists"
      list_artists
    elsif input == "list genres"
      list_genres
    elsif input == "list by artist"
      list_by_artist
    elsif input == "list by genre"
      list_by_genre
    elsif input == "play song"
      play_song
    end
  end
  end
  # def files #returns all of the imported filenames.
  #    Dir.entries(@path).select! {|entry| entry.end_with?(".mp3")}
  # end
  #
  # def import #.import imports all of the files from the library, instantiating a new Song object for each file.
  #   self.files.each do |filename| # imports the files into the library by invoking Song.create_from_filename
  #     Song.create_from_filename(filename)
  #   end
  # end
  def list_artists
    Artist.all.sort{|a, b| a.name <=> b.name}.each_with_index do |index, name|
      puts "#{index + 1}. #{name.name}"
    end

  end
  def list_songs
    Songs.all.sort{|a, b| a.name <=> b.name}.each_with_index do |index, name|
      puts "#{index + 1}. #{name.name}"
    end

  end
  def list_genres
    Genre.all.sort{|a, b| a.name <=> b.name}.each_with_index do |g, i|
      puts "#{i+1}. #{g.name}"
    end
  end

  def list_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip

    if artist = Artist.find_by_name(input)
      artist.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |s, index|
        puts "#{index+1}. #{s.name} - #{s.genre.name}"
      end
    end
  end

  def list_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

    if genre = Genre.find_by_name(input)
      genre.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  def play_song
  puts "Which song number would you like to play?"
  input = gets.strip.to_i
  if input > 0 && input <= Song.all.length
    array = Song.all.sort{|a, b| a.name <=> b.name}
    song = array[input-1]
    puts "Playing #{song.name} by #{song.artist.name}"
  end
end
end