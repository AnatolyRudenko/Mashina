//
//  ConfirmProtocols.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

protocol ConfirmConfiguratorProtocol {
    func configure(with viewController: ConfirmViewController)
}

protocol ConfirmViewProtocol: class {
    var localCar: LocalCar? { get set }
    func addImageView(imageView: UIImageView)
    func setName(_ text: String)
    func setImage(_ image: UIImage?)
    func showPopUp(_ view: PopUpView)
}

protocol ConfirmPresenterProtocol: class {
    var router: ConfirmRouterProtocol! { get set }
    func configureView(with stackView: UIStackView)
    func editButtonPressed()
    func deleteButtonPressed()
    func arrowButtonPressed(carName: String)
}

protocol ConfirmInteractorProtocol {
    var newCar: Bool { get }
    func saveChanges(car: LocalCar?)
    func delete()
    func createPopUp() -> PopUpView
}

protocol ConfirmRouterProtocol {
    func goToEditVC(with localCar: LocalCar)
    func goToListVC()
    func dismiss()
}
