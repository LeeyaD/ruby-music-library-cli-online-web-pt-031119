require 'pry'
class MusicLibraryController
  include Concerns::Findable

  def initialize(path = "./db/mp3s")
    mi = MusicImporter.new(path)
    mi.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    4.times do
      input = gets.chomp! unless input == "exit"
    end

  end

  def class_sort(klass)
    klass.all.sort_by{|obj| obj.name}
  end

  def list_songs
    class_sort(Song).each.with_index(1) do |song, i|
     puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

   def list_artists
     class_sort(Artist).each.with_index(1) do |singer, i|
      puts "#{i}. #{singer.name}"
      end
    end

    def list_genres
      class_sort(Genre).each.with_index(1) do |genre, i|
        puts "#{i}. #{genre.name}"
      end
    end

    def get_artist(input)
      Artist.all.find {|singer| singer.name == input}
      #take in users input & find said artist in Artist class
    end


    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.strip #<need to know the artist

      if artist = Artist.find_by_name(input)
        artist.songs.sort_by(&:name).each.with_index(1) do |song, i|
          puts "#{i}. #{song.name} - #{song.genre.name}"
        end
      end
    end

    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.strip

      if genre = Genre.find_by_name(input)
        genre.songs.sort_by(&:name).each.with_index(1) do |song, i|
          puts "#{i}. #{song.artist.name} - #{song.name}"
        end
      end
    end

    def play_song
      list_songs
      puts "Which song number would you like to play?"
      input = gets.strip.to_i
      #binding.pry
      input > 0 && input < Song.all.size ? song = Song.all[input] : nil#ensures input is valid

#upon receiving valid input 'plays' the matching song from the alphabetized list output by #list_songs
#to receive(:puts).with("Which song number would you like to play?")
#to receive(:puts).with("Playing Larry Csonka by Action Bronson")
#doesn't puts anything out if a matching song isn't found
#checks that user entered a number between 1 and the total number of songs in library otherwise it does nothing
    end
end
