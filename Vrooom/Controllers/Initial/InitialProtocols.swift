//
//  InitialProtocols.swift
//  Vrooom
//
//  Created by Admin on 16.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

protocol InitialConfiguratorProtocol {
    func configure(with viewController: InitialViewController)
}

protocol InitialViewProtocol: class {}

protocol InitialPresenterProtocol: class {
    var router: InitialRouterProtocol! { set get }
    func addButtonClicked()
    func listButtonClicked()
    func switchIconIfNeeded(darkTheme: Bool)
}

protocol InitialInteractorProtocol {
    func newCar()
    func switchIconIfNeeded(darkTheme: Bool)
}

protocol InitialRouterProtocol {
    func goToEditVC(on view: InitialViewProtocol)
    func goToListVC(on view: InitialViewProtocol)
}
