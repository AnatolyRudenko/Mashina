//
//  InitialPresenter.swift
//  Vrooom
//
//  Created by Admin on 16.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

final class InitialPresenter: InitialPresenterProtocol {
    weak var view: InitialViewProtocol!
    var interactor: InitialInteractorProtocol!
    var router: InitialRouterProtocol!
    
    required init(view: InitialViewProtocol) {
        self.view = view
    }
    
    func addButtonClicked() {
        self.interactor.newCar()
        self.router.goToEditVC(on: view)
    }
    
    func listButtonClicked() {
        self.router.goToListVC(on: view)
    }
    
    func switchIconIfNeeded(darkTheme: Bool) {
        self.interactor.switchIconIfNeeded(darkTheme: darkTheme)
    }
}
