require 'pry'
class Artist
    extend Concerns::Findable

    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end 

    def save
        @@all << self
    end 

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end 
    
    def add_song(song)
        if song.artist == nil
            song.artist = self    
        else
            @songs << song unless @songs.include?(song)
        end
    end

    def songs
        @songs
    end

    def genres
        @songs.collect {|song| song.genre}.uniq
    end

    def self.all
        @@all 
    end 

    def self.destroy_all
        @@all.clear
    end

end