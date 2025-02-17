//
//  NotesTableViewCell.swift
//  TabBarDemo
//
//  Created by admin on 12/30/24.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var noteCellText: UILabel!
    @IBOutlet weak var noteCellBodyPreview: UITextView!
    @IBOutlet weak var notesIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
