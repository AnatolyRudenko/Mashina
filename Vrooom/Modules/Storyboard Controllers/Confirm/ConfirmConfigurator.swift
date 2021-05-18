//
//  ConfirmConfigurator.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

final class ConfirmConfigurator: ConfirmConfiguratorProtocol {
    
    func configure(with viewController: ConfirmViewController) {
        let presenter = ConfirmPresenter(view: viewController)
        let interactor = ConfirmInteractor(presenter: presenter)
        let router = ConfirmRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.editable = false
    }
}
