//
//  FontManager.swift
//  Vrooom
//
//  Created by Admin on 03.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

class FontManager {
    
    class func texGyreRegular(size: CGFloat) -> UIFont {
        let font = UIFont.init(name: "TeXGyreAdventor-Regular", size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
}
