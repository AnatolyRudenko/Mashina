//
//  FontManager.swift
//  Vrooom
//
//  Created by Admin on 03.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

struct FontManager {
    
    static func texGyreRegular(size: CGFloat) -> UIFont {
        let font = UIFont.init(name: "TeXGyreAdventor-Regular", size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func texGyreBold(size: CGFloat) -> UIFont {
        let font = UIFont.init(name: "TeXGyreAdventor-Bold", size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static var customBlue = UIColor(named: "customBlue")
    static var blueAndWhite = UIColor(named: "blueAndWhite")
    static var labelColor: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
}
