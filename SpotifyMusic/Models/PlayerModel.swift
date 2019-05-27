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
    
    func playStream(fileUrl: String)  {
        let mp3URL = NSURL(string: fileUrl)
        avPlayer = AVPlayer(url: mp3URL as! URL)
        avPlayer.play()
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
    
}


