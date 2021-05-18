//
//  PropertiesProtocols.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

protocol PropertiesPresenterProtocol: class {
    var visualSetupIsOver: Bool { get set }
    var editable: Bool { get }
    var propertyViews: [CarPropertyView] { get }
    var image: UIImage? { get }
    
    func setPropertyViewsIn(stackView: UIStackView)
    func buildLocalCar() -> LocalCar
    func applyCar()
}

protocol PropertiesInteractorProtocol {
    func getCarImage() -> UIImage
}
