//
//  EditProtocols.swift
//  Vrooom
//
//  Created by Admin on 18.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

protocol EditConfiguratorProtocol {
    func configure(with viewController: EditViewController)
}

protocol EditViewProtocol: class {
    var localCar: LocalCar? { get set }
}

protocol EditPresenterProtocol: class {
    var router: EditRouterProtocol! { get set }
    func configureView(with stackView: UIStackView)
    
}

protocol EditInteractorProtocol {
    
}

protocol EditRouterProtocol {
    func goToListVC(from view: EditViewProtocol, with localCar: LocalCar)
}
