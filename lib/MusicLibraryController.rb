require 'pry'
class MusicLibraryController
    attr_accessor :path

    def initialize(path='./db/mp3s')
        @path = path 
        file = MusicImporter.new(path)
        Song.all << file.import
    end

    def call
        input = gets.strip
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        # if input != exit
            case input
            when 'list songs'
                list_songs
            when 'list artists'
                list_artists
            when 'list genres'
                list_genres
            when 'list artist'
                list_songs_by_artist
            when 'list genre'
                list_songs_by_genre
            when 'play song'
                play_song
            end

        # else
        #     call
        # end 

    end 

    def list_songs
        Song.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |song,index|
            binding.pry 
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            #binding.pry 
        end
    end

    def list_artists
        Artist.all.sort_by {|artist|artist.name}.each.with_index(1) do |artist,index|
            puts "#{index}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.sort_by {|genre|genre.name}.each.with_index(1) do |genre,index|
            puts "#{index}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        input = gets.strip
        puts "Please enter the name of an artist:"
        #Song.all.detect{|artist|song.artist.name == input ? puts }
        if artist = Artist.find_by_name(input)
            artist.songs.sort_by {|song|song.name}.each.with_index(1) do |song,index|
                puts "#{index}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        input = gets.strip
        puts "Please enter the name of a genre:"
        if genre = Genre.find_by_name(input)
            genre.songs.sort_by {|song|song.name}.each.with_index(1) do |song,index|
                puts "#{index}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        input = gets.strip.to_i
        list_songs
        puts "Which song number would you like to play?"
       

        if (1..Song.all.length).include?(input)
            #song = list_song[input+2]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end

end 