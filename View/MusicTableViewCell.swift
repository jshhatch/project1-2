//
//  MusicTableViewCell.swift
//  TabBarDemo
//
//  Created by admin on 12/30/24.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var musicArtistText: UILabel!
    @IBOutlet weak var musicCellText: UILabel!
    @IBOutlet weak var musicIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //setEditing(true, animated: true)
        // Configure the view for the selected state
    }

}
