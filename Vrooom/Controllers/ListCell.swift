//
//  CarTableViewCell.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit


class ListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImage(_ image:UIImage) { //resizes image and sets it
        let hRatio = image.size.height / image.size.width
        let newImageHeight = hRatio * UIScreen.main.bounds.width
        imageHeightConstraint.constant = newImageHeight
        carImageView.image = image
        carImageView.layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
