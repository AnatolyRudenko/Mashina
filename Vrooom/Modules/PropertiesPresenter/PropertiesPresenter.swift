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
        self.parentInteractor = PropertiesInteractor()
        self.localCar = localCar
    }
    
    func setPropertyViewsIn(stackView: UIStackView) {
        for (index, type) in PropertyType.allCases.enumerated() {
            let frame = CGRect(x: 0, y: 0, width: stackView.bounds.width, height: 40)
            let view = CarPropertyView(frame: frame, type: type, editable: self.editable)
            self.propertyViews.append(view)
            if index == 0 && !self.editable {
                continue
            }
            stackView.addArrangedSubview(view)
        }
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
