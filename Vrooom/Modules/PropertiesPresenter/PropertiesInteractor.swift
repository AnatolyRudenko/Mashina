//
//  PropertiesInteractor.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

final class PropertiesInteractor: PropertiesInteractorProtocol {
    
    weak var presenter: PropertiesPresenterProtocol!
    
    required init(presenter: PropertiesPresenterProtocol) {
        self.presenter = presenter
    }
    
    func addCarPropertyViews(to stackView: UIStackView) {
        for (index, type) in PropertyType.allCases.enumerated() {
            let frame = CGRect(x: 0, y: 0, width: stackView.bounds.width, height: 40)
            let view = CarPropertyView(frame: frame, type: type, editable: self.presenter.editable)
            self.presenter.setPropertyView(view)
            if index == 0 && !self.presenter.editable {
                continue
            }
            stackView.addArrangedSubview(view)
        }
    }
    
    func getCarImage() -> UIImage {
        return ImageManager().defaultImage
    }
}
