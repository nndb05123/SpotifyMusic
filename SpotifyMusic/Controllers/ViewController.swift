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
        changeIMGPlayButton()
    }
    
    func setSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            print(error)
        }
    }
    
    func changeIMGPlayButton()  {
        if (player.avPlayer.rate > 0) {
            playpauseButton.setImage(UIImage(named: "pauseButton"), for: UIControl.State.normal)
        } else
        {
            playpauseButton.setImage(UIImage(named: "playButton"), for: UIControl.State.normal)
        }
    }
    
    func handleInterruption(notification: NSNotification) {
        player.pauseAudio()
        let interruptionTypeAsObject = notification.userInfo![AVAudioSessionInterruptionTypeKey] as! NSNumber
        let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeAsObject.uintValue)
        
        if let type = interruptionType {
            if type == .ended {
                player.playAudio()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        player = Player()
        player.playStream(fileUrl: url)
        changeIMGPlayButton()
        setSession()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: "handleInterruption" , name: AVAudioSession.interruptionNotification, object: nil)
        
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        if event?.type == UIEvent.EventType.remoteControl {
            if event!.subtype == UIEvent.EventSubtype.remoteControlPause {
                print("Pause")
                player.pauseAudio()
            } else if event!.subtype == UIEvent.EventSubtype.remoteControlPlay {
                print("Playing")
                player.playAudio()
            }
        }
    }

}

