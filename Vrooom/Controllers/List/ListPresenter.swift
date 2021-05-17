//
//  ListPresenter.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

class ListPresenter: ListPresenterProtocol {
    weak var view: ListViewProtocol!
    var interactor: ListInteractorProtocol!
    var router: ListRouterProtocol!
    
    required init(view: ListViewProtocol) {
        self.view = view
    }
}
