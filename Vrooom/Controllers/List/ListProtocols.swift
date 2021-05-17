//
//  ListProtocols.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

protocol ListConfiguratorProtocol: class {
    func configure(with viewController: ListViewController)
}
    
protocol ListViewProtocol: class {
    func prepareContent()
    
}

protocol ListPresenterProtocol: class {
    var router: ListRouterProtocol! { get set }
    var dbCars: [CarList] { get }
    var cellImages: [UIImage]? { get }
    func configureView()
    func prepareContent()
    func backButtonPressed()
    func carCellTapped(index: Int)
}

protocol ListInteractorProtocol {
    var database: DatabaseProtocol? { get }
    var imageManager: ImageManager? { get }
    var dbCars: [CarList] { get }
    func getCellImages() -> [UIImage]?
    func setGlobalCarProperties(index: Int)
    func getLocalCar(at index: Int) -> LocalCar
}

protocol ListRouterProtocol: class {
    func goBack()
    func goToConfirmVC(from view: ListViewProtocol, with localCar: LocalCar)
}
