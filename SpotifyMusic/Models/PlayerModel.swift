//
//  PlayerModel.swift
//  SpotifyMusic
//
//  Created by Bao Duy on 5/26/19.
//  Copyright © 2019 Bao Duy. All rights reserved.
//

import Foundation
import MediaPlayer

class Player {
    
    var avPlayer : AVPlayer!
    
    init() {
        avPlayer = AVPlayer()
        
    }
    
    func playStream(fileUrl: NSURL,name: String, artist: String)  {
        avPlayer = AVPlayer(url: fileUrl as URL)
        avPlayer.play()
        setPlayingScreen(name: name, artist: artist)
        
    }
    
    func playAudio()  {
        if (avPlayer.rate == 0 && avPlayer.error == nil)
        {
            avPlayer.play()
        }
    }
    
    func pauseAudio() {
        if (avPlayer.rate > 0 && avPlayer.error == nil)
        {
            avPlayer.pause()
        }
    }
    
    func setPlayingScreen(name: String, artist: String) {
        let songInfo = [
            MPMediaItemPropertyTitle: name,
            MPMediaItemPropertyArtist: artist
        ]
        MPNowPlayingInfoCenter.default().nowPlayingInfo = songInfo
    }
    
}


