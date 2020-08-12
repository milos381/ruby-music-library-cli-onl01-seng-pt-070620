class MusicImporter
  attr_accessor :path, :song, :artist, :genre
  def initialize(path)
    @path = path
  end

  def files #returns all of the imported filenames.
     Dir.entries(@path).select! {|entry| entry.end_with?(".mp3")}
  end

  def import #.import imports all of the files from the library, instantiating a new Song object for each file.
    self.files.each do |filename| # imports the files into the library by invoking Song.create_from_filename
      Song.create_from_filename(filename)
    end
  end
end
