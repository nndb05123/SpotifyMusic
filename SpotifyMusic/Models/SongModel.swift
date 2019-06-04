//
//  SongModel.swift
//  SpotifyMusic
//
//  Created by Bao Duy on 6/1/19.
//  Copyright © 2019 Bao Duy. All rights reserved.
//

import Foundation

class SongModel {
    var ID: Int!
    var SongName: String!
    var Artist: String!
    var Avatar: String!
    var mp3URL: String!
    
    init(ID: String, SongName: String, Artist: String, Avatar: String, mp3URL: String) {
        self.ID = Int(ID)
        self.SongName = SongName
        self.Artist = Artist
        self.Avatar = Avatar
        self.mp3URL = mp3URL
    }
    
    func getID() -> Int {
        return ID
    }
    
    func getSongName() -> String {
        return SongName
    }
    
    func getArtist() -> String {
        return Artist
    }
    
    func getAvatar() -> String {
        return Avatar
    }
    
    func getmp3URL() -> String {
        return mp3URL
    }
    
}
