//
//  Constants.swift
//  Vrooom
//
//  Created by Admin on 25.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import Foundation

struct K {
    struct segues {
        static let toEdit = "toEdit"
        static let toList = "toList"
        static let toConfirm = "toConfirm"
        static let toEditFromConfirm = "toEditFromConfirm"
        static let toListFromConfirm = "toListFromConfirm"
        static let fromListToConfirm = "fromListToConfirm"
    }
    struct cell {
        static let nibName = "CarTableViewCell"
        static let reuseIdentifier = "cell"
    }
    struct strings {
        static let libraryAccessDenied = "Доступ к библиотеке ограничен. Перейдите в настройки и разрешите доступ к фото"
        static let unnamedCarPopUp = "Что же это за машина без имени?"
    }
}
