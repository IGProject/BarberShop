//: Playground - noun: a place where people can play

import UIKit

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name:String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String,artist:String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Rick Astley"),
    Song(name: "Never Gonna Give You Up", artist: "dddd")]


var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    }else if item is Song {
        songCount += 1
    }
}

print("Media libray countains move:\(movieCount),and song:\(songCount)")
