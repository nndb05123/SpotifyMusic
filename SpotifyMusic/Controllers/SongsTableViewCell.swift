//
//  SongsTableViewCell.swift
//  SpotifyMusic
//
//  Created by Bao Duy on 6/1/19.
//  Copyright © 2019 Bao Duy. All rights reserved.
//

import UIKit

class SongsTableViewCell: UITableViewCell {

    @IBOutlet weak var lbSongName: UILabel!
    @IBOutlet weak var lbArtistName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
