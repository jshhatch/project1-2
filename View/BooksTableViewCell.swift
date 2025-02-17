//
//  BooksTableViewCell.swift
//  TabBarDemo
//
//  Created by admin on 12/30/24.
//

import UIKit

class BooksTableViewCell: UITableViewCell {

    @IBOutlet weak var booksIcon: UIImageView!
    @IBOutlet weak var bookCellText: UILabel!
    @IBOutlet weak var authorText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
