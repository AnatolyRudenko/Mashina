//
//  RealmManager.swift
//  Vrooom
//
//  Created by Admin on 04.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmManager: DatabaseProtocol {
    
    private(set) var realmCars: Results<CarList>?
    private let realm = try! Realm()
    
    init() {
        self.realmCars = realm.objects(CarList.self)
    }
    
    //MARK: - Database protocol
    
    var cars: [CarList] {
        if let realmCars = self.realmCars {
            return Array(realmCars)
        } else {
            return [CarList]()
        }
    }
    
    func createDBCar(from localCar: LocalCar) -> CarList {
        return self.createRealmCar(from: localCar)
    }
    func convertDBCarToLocal(_ dbCar: CarList) -> LocalCar {
        return self.convertRealmCarToLocal(dbCar)
    }
    
    func save(_ localCar: LocalCar?) {
        guard let localCar = localCar else { return }
        let newCar = self.createRealmCar(from: localCar)
        do {
            try realm.write {
                realm.add(newCar)
            }
        } catch {
            print("error saving to realm: \(error)")
        }
    }
    
    func edit(_ localCar: LocalCar?) {
        guard let localCar = localCar,
              let safeIndex = OperatedCar.index,
              let carToEdit = realmCars?[safeIndex]
        else { return }
        
        let newCar = self.createRealmCar(from: localCar)
        do {
            try realm.write {
                carToEdit.name = newCar.name
                carToEdit.year = newCar.year
                carToEdit.model = newCar.model
                carToEdit.bodyType = newCar.bodyType
                carToEdit.mileage =  newCar.mileage
                carToEdit.manufacturer = newCar.manufacturer
                carToEdit.country = newCar.country
                carToEdit.imageName = newCar.imageName
            }
        } catch {
            print("Error editing car, \(error)")
        }
    }
    
    func delete() {
        guard !OperatedCar.newCar,
              let index = OperatedCar.index,
              let car = realmCars?[index]
        else { return }
        
        do {
            try realm.write{
                realm.delete(car)
            }
        } catch {
            print("Error deleting car: \(error)")
        }
    }
    
    //MARK: - Private methods
    private func createRealmCar(from localCar: LocalCar) -> CarList {
        let car = CarList()
        car.name = localCar.name
        car.model = localCar.model
        car.year = localCar.year
        car.mileage = localCar.mileage
        car.bodyType = localCar.bodyType
        car.manufacturer = localCar.manufacturer
        car.country = localCar.country
        if let image = localCar.image, let name = localCar.name {
            car.imageName = ImageManager().saveImageAndGetItsPath(image: image, name: name)
        }
        return car
    }
    
    private func convertRealmCarToLocal(_ realmCar: CarList) -> LocalCar {
        var car = LocalCar()
        car.name = realmCar.name
        car.model = realmCar.model
        car.year = realmCar.year
        car.mileage = realmCar.mileage
        car.bodyType = realmCar.bodyType
        car.manufacturer = realmCar.manufacturer
        car.country = realmCar.country
        car.image = ImageManager().getImageFromImageName(realmCar.imageName)
        return car
    }
}
