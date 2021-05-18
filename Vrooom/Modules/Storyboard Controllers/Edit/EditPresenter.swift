//
//  EditPresenter.swift
//  Vrooom
//
//  Created by Admin on 18.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

final class EditPresenter: PropertiesPresenter, EditPresenterProtocol {
    
    weak var view: EditViewProtocol!
    var interactor: EditInteractorProtocol!
    var router: EditRouterProtocol!
    
    init(view: EditViewProtocol) {
        self.view = view
        super.init(localCar: self.view.localCar)
    }
    
    required init(localCar: LocalCar?) {
        fatalError("init(localCar:) has not been implemented")
    }
    
    func configureView(with stackView: UIStackView) {
        guard !super.visualSetupIsOver else { return }
        super.setPropertyViewsIn(stackView: stackView)
        self.addLoadImageButton(to: stackView)
        self.moveButtonToBottom(in: stackView)
        super.applyCar()
    }
    
    func setupImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.view.presentImagePicker(imagePicker)
        } else {
            self.view.showPopUp(self.interactor.createPopUp())
        }
    }
    
    func arrowPressed() {
        self.router.goToConfirmVC(with: super.buildLocalCar())
    }

    private func moveButtonToBottom(in stackView: UIStackView) {
        let buttonView = stackView.arrangedSubviews[0]
        stackView.removeArrangedSubview(buttonView)
        stackView.addArrangedSubview(buttonView)
    }

    private func addLoadImageButton(to stackView: UIStackView) {
        let button = UIButton()
        button.setTitle("Загрузить изображение", for: .normal)
        button.setTitleColor(FontManager.labelColor, for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = FontManager.customBlue?.cgColor
        button.layer.cornerRadius = 5
        self.view.addActionToLoadImageButton(button)
        stackView.addArrangedSubview(button)
    }
}

