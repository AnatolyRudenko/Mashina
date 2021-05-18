//
//  EditConfigurator.swift
//  Vrooom
//
//  Created by Admin on 18.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

final class EditConfigurator: EditConfiguratorProtocol {
    
    func configure(with viewController: EditViewController) {
        let presenter = EditPresenter(view: viewController)
        let interactor = EditInteractor(presenter: presenter)
        let router = EditRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.editable = true
    }
}
