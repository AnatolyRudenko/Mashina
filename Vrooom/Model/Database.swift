//
//  Database.swift
//  Vrooom
//
//  Created by Admin on 16.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

protocol DatabaseProtocol {
    var cars: [CarList] { get }
    func save(_ localCar: LocalCar?)
    func edit(_ localCar: LocalCar?)
    func delete()
    func createDBCar(from localCar: LocalCar) -> CarList
    func convertDBCarToLocal(_ dbCar: CarList) -> LocalCar
}

struct Database {
    func instance() -> DatabaseProtocol {
        return RealmManager()
    }
}
