//
//  FeedCell.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 21.04.2023.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var cellUserEmailLabel: UILabel!
    @IBOutlet weak var cellsnapImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
