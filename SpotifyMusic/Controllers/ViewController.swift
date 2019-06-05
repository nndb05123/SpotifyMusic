//
//  ViewController.swift
//  SpotifyMusic
//
//  Created by Bao Duy on 5/26/19.
//  Copyright © 2019 Bao Duy. All rights reserved.
//

import UIKit
import  MediaPlayer
import  Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    var player : Player!
    var songs : [SongModel] = []
    var url = "https://spotifyappbybaoduy.000webhostapp.com/phokhongemtd.mp3"
    
    var isPlayingMusic:Bool = false
    
    @IBOutlet weak var playpauseButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textTimBaiHat: UITextField!
    
    @IBAction func searchMusicClicked(_ sender: Any) {
        songs.removeAll()
        searchMusic(songName: textTimBaiHat.text!)
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
        view.endEditing(true)
    }
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongsTableViewCell", for: indexPath) as! SongsTableViewCell
        cell.lbSongName.text = songs[indexPath.row].getSongName()
        cell.lbArtistName.text = songs[indexPath.row].getArtist()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let songName = String(songs[indexPath.row].getSongName())
        let artistName = String(songs[indexPath.row].getArtist())
        let mp3Url = String(songs[indexPath.row].getmp3URL())
        let mp3NSURL = NSURL(fileURLWithPath: mp3Url)
        player.pauseAudio()
        player.playStream(fileUrl: mp3NSURL, name: songName, artist: artistName)
        changeIMGPlayButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        player = Player()
//        player.playStream(fileUrl: url)
//        changeIMGPlayButton()
        retrieveSongs()
        tableView.delegate = self
        tableView.dataSource = self
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
    //Hàm fecth Data from URL
    func retrieveSongs() {
        Alamofire.request("https://spotifyappbybaoduy.000webhostapp.com/getMusic.php").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                self.parseSongs(data: utf8Text)
            }
        }
        
//        let url = URL(string: "https://spotifyappbybaoduy.000webhostapp.com/getMusic.php")!
//
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
//        }
//
//        task.resume()
    }
    
    func searchMusic(songName: String) {
        Alamofire.request("https://spotifyappbybaoduy.000webhostapp.com/getSearchMusic.php?songname=\(songName)").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                self.parseSongs(data: utf8Text)
            }
        }
    }
    
    func parseSongs(data: String) {
        if (data.contains("*")) {
            let dataArray = (data as String).split(separator: "*")
            for item in dataArray {
                let itemData = item.split(separator: ",")
                let newSong = SongModel(ID: String(itemData[0]), SongName: String(itemData[1]), Artist: String(itemData[2]), Avatar: String(itemData[3]), mp3URL: String(itemData[4]))
                songs.append(newSong)
            }
            for s in songs {
                print(s.getSongName())
            }
            
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
            

        }
    }
}

