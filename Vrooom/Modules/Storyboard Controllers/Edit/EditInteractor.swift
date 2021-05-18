//
//  EditInteractor.swift
//  Vrooom
//
//  Created by Admin on 18.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import Foundation

final class EditInteractor: EditInteractorProtocol {
    
    weak var presenter: EditPresenterProtocol!
    
    required init(presenter: EditPresenterProtocol) {
        self.presenter = presenter
    }
    
    func createPopUp() -> PopUpView {
        return PopUpView(text: K.strings.libraryAccessDenied)
    }
}

