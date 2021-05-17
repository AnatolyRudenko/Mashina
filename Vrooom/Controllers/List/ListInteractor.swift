//
//  ListInteractor.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

final class ListInteractor: ListInteractorProtocol {
    
    func getCellImages() -> [UIImage]? {
        var images = [UIImage]()
        for car in self.dbCars {
            if let image = self.imageManager?.getImageFromImageName(car.imageName) {
                images.append(image)
            }
        }
        return images.count == 0 ? nil : images
    }
    
    var imageManager: ImageManager?
    
    
    var dbCars: [CarList] {
        return self.database?.cars ?? []
    }
    
    var database: DatabaseProtocol?
    
    weak var presenter: ListPresenterProtocol!
    
    required init(presenter: ListPresenterProtocol) {
        self.presenter = presenter
        self.database = Database().instance()
        self.imageManager = ImageManager()
    }
    
    func setGlobalCarProperties(index: Int) {
        OperatedCar.index = index
        OperatedCar.newCar = false
    }
    
    func getLocalCar(at index: Int) -> LocalCar {
        guard let database = self.database else { return LocalCar() }
        let dbCar = database.cars.count > index ?
            database.cars[index] :
            database.cars[0]
        return database.convertDBCarToLocal(dbCar)
    }
}
