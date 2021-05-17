//
//  ListInteractor.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

final class ListInteractor: ListInteractorProtocol {
    
    weak var presenter: ListPresenterProtocol!
    
    required init(presenter: ListPresenterProtocol) {
        self.presenter = presenter
    }
}
