//
//  ConfirmInteractor.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

final class ConfirmInteractor: ConfirmInteractorProtocol {
    
    weak var presenter: ConfirmPresenterProtocol!
    
    var newCar: Bool {
        OperatedCar.newCar
    }
    
    required init(presenter: ConfirmPresenterProtocol) {
        self.presenter = presenter
    }
    
    func saveChanges(car: LocalCar?) {
        self.newCar ?
            Database().instance().save(car) :
            Database().instance().edit(car)
    }
    
    func delete() {
        Database().instance().delete()
    }
    
    func createPopUp() -> PopUpView {
        return PopUpView(text: K.strings.unnamedCarPopUp)
    }
}
