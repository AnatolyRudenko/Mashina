//
//  ListPresenter.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

class ListPresenter: ListPresenterProtocol {
    var dbCars: [CarList] {
        return self.interactor.dbCars
    }
    
    var cellImages: [UIImage]?
    
    func prepareContent() {
        DispatchQueue.main.async {
            self.cellImages = self.interactor.getCellImages()
        }
    }
    
    func configureView() {
        
    }
    
    func backButtonPressed() {
        self.router.goBack()
    }
    
    func carCellTapped(index: Int) {
        self.interactor.setGlobalCarProperties(index: index)
        let car = self.interactor.getLocalCar(at: index)
        self.router.goToConfirmVC(from: self.view, with: car)
    }
    
    weak var view: ListViewProtocol!
    var interactor: ListInteractorProtocol!
    var router: ListRouterProtocol!
    
    required init(view: ListViewProtocol) {
        self.view = view
    }
}
