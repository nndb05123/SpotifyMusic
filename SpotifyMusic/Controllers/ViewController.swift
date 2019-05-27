//
//  ViewController.swift
//  SpotifyMusic
//
//  Created by Bao Duy on 5/26/19.
//  Copyright © 2019 Bao Duy. All rights reserved.
//

import UIKit
import  MediaPlayer

class ViewController: UIViewController {

    var player : Player!
    
    var url = "https://aredir.nixcdn.com/NhacCuaTui963/ThiThoi-Reddy-5461229.mp3"
    
    var isPlayingMusic:Bool = false
    
    @IBOutlet weak var playpauseButton: UIButton!
    
    @IBAction func playpauseButtonClicked(_ sender: Any) {

        if (player.avPlayer.rate > 0) {
            player.pauseAudio()
        } else
        {
            player.playAudio()
        }
        changIMGPlayButton()
    }
    
    func changIMGPlayButton()  {
        if (player.avPlayer.rate > 0) {
            playpauseButton.setImage(UIImage(named: "pauseButton"), for: UIControl.State.normal)
        } else
        {
            playpauseButton.setImage(UIImage(named: "playButton"), for: UIControl.State.normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        player = Player()
        player.playStream(fileUrl: url)

    }
    


}

