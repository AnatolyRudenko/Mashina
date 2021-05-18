//
//  InitialConfigurator.swift
//  Vrooom
//
//  Created by Admin on 16.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

final class InitialConfigurator: InitialConfiguratorProtocol {
    
    func configure(with viewController: InitialViewController) {
        let presenter = InitialPresenter(view: viewController)
        let interactor = InitialInteractor(presenter: presenter)
        let router = InitialRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
