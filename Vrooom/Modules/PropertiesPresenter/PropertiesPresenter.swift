//
//  PropertiesPresenter.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

class PropertiesPresenter: PropertiesPresenterProtocol {
    
    var parentInteractor: PropertiesInteractorProtocol!
    lazy var editable = true
    lazy var visualSetupIsOver = false
    
    var propertyViews = [CarPropertyView]()
    var localCar: LocalCar?
    var image: UIImage?
    
    required init(localCar: LocalCar?) {
        self.parentInteractor = PropertiesInteractor(presenter: self)
        self.localCar = localCar
    }
    
    func setPropertyView(_ view: CarPropertyView) {
        self.propertyViews.append(view)
    }
    
    func setPropertyViewsIn(stackView: UIStackView) {
        self.parentInteractor.addCarPropertyViews(to: stackView)
        self.visualSetupIsOver = true
    }
    
    func buildLocalCar() -> LocalCar {
        var car = LocalCar()
        for view in self.propertyViews {
            let value = view.readValue()
            view.type.applyPropertyToCar(&car, value: value)
        }
        car.image = self.image == nil ?
            self.parentInteractor.getCarImage() :
            self.image
        return car
    }
    
    func applyCar() {
        guard let car = self.localCar else { return }
        for view in self.propertyViews {
            let value = view.type.extractPropertyFromCar(car)
            view.setValue(value)
        }
        if let image = car.image {
            self.image = image
        }
    }
}
