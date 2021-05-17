//
//  ConfirmProtocols.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

protocol ConfirmConfiguratorProtocol {
    func configure(with viewController: ConfirmViewController)
}

protocol ConfirmViewProtocol: class {
    var localCar: LocalCar? { get set }
}

protocol ConfirmPresenterProtocol: class {
    var router: ConfirmRouterProtocol! { get set }
}

protocol ConfirmInteractorProtocol {
    
}

protocol ConfirmRouterProtocol {
    func goToEditVC(from view: ConfirmViewProtocol)
    func goToListVC(from view: ConfirmViewProtocol)
}
