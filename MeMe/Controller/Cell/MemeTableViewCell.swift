//
//  MemeTableViewCell.swift
//  MeMe
//
//  Created by Rafael Cunha de Oliveira on 03/06/18.
//  Copyright © 2018 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageTableViewCell: UIImageView!
    @IBOutlet weak var labelTableViewCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
