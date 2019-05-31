//
//  MusicModel.swift
//  SpotifyMusic
//
//  Created by Bao Duy on 5/31/19.
//  Copyright © 2019 Bao Duy. All rights reserved.
//

import Foundation

class MusicModel {
    
    func retrieveSongs() {
//        let url = URL(string: "https://spotifyappbybaoduy.000webhostapp.com/getMusic.php")
        let url = URL(string: "https://spotifyappbybaoduy.000webhostapp.com/getMusic.php")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
        
    }
}
