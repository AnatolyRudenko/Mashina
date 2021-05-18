//
//  ListPresenter.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListViewProtocol!
    var interactor: ListInteractorProtocol!
    var router: ListRouterProtocol!
    lazy var cellImages = [UIImage]()
    lazy var cellHeights = [CGFloat]()
    var dbCars: [CarList] {
        return self.interactor.dbCars
    }
    
    required init(view: ListViewProtocol) {
        self.view = view
    }
    
    func prepareCellImages() {
        DispatchQueue.main.async {
            self.cellImages = self.interactor.getCellImages()
        }
    }
    
    func saveCellHeight(index: Int, cellHeight: CGFloat, imageSize: CGSize) {
        guard self.cellHeights.count == index,
              UIScreen.main.bounds.width == imageSize.width
              else { return }
        let height = cellHeight + imageSize.height
        self.cellHeights.append(height)
    }
    
    func configureView() {
        self.view?.setupTable()
    }
    
    func backButtonPressed() {
        self.router.goBack()
    }
    
    func carCellTapped(index: Int) {
        self.interactor.setGlobalCarProperties(index: index)
        let car = self.interactor.getLocalCar(at: index)
        self.router.goToConfirmVC(from: self.view, with: car)
    }
}
