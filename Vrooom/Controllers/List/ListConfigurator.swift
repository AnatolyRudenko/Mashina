//
//  ListConfigurator.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

class ListConfigurator: ListConfiguratorProtocol {
    
    func configure(with viewController: ListViewController) {
        let presenter = ListPresenter(view: viewController)
        let interactor = ListInteractor(presenter: presenter)
        let router = ListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
