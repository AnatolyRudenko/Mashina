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
    var router: InitialRouterProtocol! { get set }
    func addButtonClicked()
    func listButtonClicked()
    func switchIconIfNeeded(darkTheme: Bool)
}

protocol InitialInteractorProtocol {
    func setGlobalCarProperties()
    func switchIconIfNeeded(darkTheme: Bool)
}

protocol InitialRouterProtocol {
    func goToEditVC()
    func goToListVC()
}
