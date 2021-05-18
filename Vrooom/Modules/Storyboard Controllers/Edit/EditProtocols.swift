//
//  EditProtocols.swift
//  Vrooom
//
//  Created by Admin on 18.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

protocol EditConfiguratorProtocol {
    func configure(with viewController: EditViewController)
}

protocol EditViewProtocol: class {
    var localCar: LocalCar? { get set }
    func addActionToLoadImageButton(_ button: UIButton)
    func presentImagePicker(_ picker: UIImagePickerController)
    func showPopUp(_ view: PopUpView)
}

protocol EditPresenterProtocol: class {
    var router: EditRouterProtocol! { get set }
    var image: UIImage? { get set }
    func configureView(with stackView: UIStackView)
    func setupImagePicker()
    func arrowPressed()
}

protocol EditInteractorProtocol {
    func createPopUp() -> PopUpView
}

protocol EditRouterProtocol {
    func goToConfirmVC(with localCar: LocalCar)
}
