//
//  carList.swift
//  Vrooom
//
//  Created by Admin on 20.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import Foundation
import RealmSwift


class CarList: Object {
    @objc dynamic var name: String?
    @objc dynamic var year: String?
    @objc dynamic var model: String?
    @objc dynamic var mileage: String?
    @objc dynamic var bodyType: String?
    @objc dynamic var country: String?
    @objc dynamic var manufacturer: String?
    @objc dynamic var imageName: String?
}
