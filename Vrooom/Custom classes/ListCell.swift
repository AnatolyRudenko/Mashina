//
//  CarTableViewCell.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

final class ListCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    
    func setName(_ name: String) {
        self.nameLabel.text = name
    }
    
    func setImage(_ image: UIImage) {
        let hRatio = image.size.height / image.size.width
        let newImageHeight = hRatio * UIScreen.main.bounds.width
        imageHeightConstraint.constant = newImageHeight
        carImageView.image = image
        carImageView.layoutIfNeeded()
    }
}
