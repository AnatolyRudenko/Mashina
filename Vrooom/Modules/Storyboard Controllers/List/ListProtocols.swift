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
    func setupTable()
}

protocol ListPresenterProtocol: class {
    var router: ListRouterProtocol! { get set }
    var dbCars: [CarList] { get }
    var cellImages: [UIImage] { get }
    var cellHeights: [CGFloat] { get }
    func configureView()
    func prepareCellImages()
    func backButtonPressed()
    func carCellTapped(index: Int)
    func saveCellHeight(index: Int, cellHeight: CGFloat, imageSize: CGSize)
}

protocol ListInteractorProtocol {
    var database: DatabaseProtocol? { get }
    var imageManager: ImageManager? { get }
    var dbCars: [CarList] { get }
    func getCellImages() -> [UIImage]
    func setGlobalCarProperties(index: Int)
    func getLocalCar(at index: Int) -> LocalCar
}

protocol ListRouterProtocol: class {
    func goBack()
    func goToConfirmVC(with localCar: LocalCar)
}
