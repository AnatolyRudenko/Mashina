//
//  InitialInteractor.swift
//  Vrooom
//
//  Created by Admin on 16.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

final class InitialInteractor: InitialInteractorProtocol {
    
    weak var presenter: InitialPresenterProtocol!
    
    required init(presenter: InitialPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setGlobalCarProperties() {
        OperatedCar.newCar = true
    }
    
    func switchIconIfNeeded(darkTheme: Bool) {
        _ = IconManager.init(dark: darkTheme)
    }
}
