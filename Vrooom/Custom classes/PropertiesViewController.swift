//
//  PropertiesViewController.swift
//  Vrooom
//
//  Created by Admin on 04.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

class PropertiesViewController: UIViewController {

    var propertyViews = [CarPropertyView]()
    var editable = true
    var localCar: LocalCar?
    var image: UIImage?
    
    func setPropertyViewsIn(stackView: UIStackView) {
        guard stackView.arrangedSubviews.count < PropertyType.allCases.count else {
            return
        }
        for type in PropertyType.allCases {
            let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40)
            let view = CarPropertyView(frame: frame, type: type, editable: true)
            stackView.addArrangedSubview(view)
            self.propertyViews.append(view)
        }
    }
    
    func buildLocalCar() -> LocalCar {
        var car = LocalCar()
        for view in self.propertyViews {
            let value = view.readValue()
            view.type.applyPropertyToCar(&car, value: value)
        }
        if let image = self.image {
            car.image = image
        }
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
