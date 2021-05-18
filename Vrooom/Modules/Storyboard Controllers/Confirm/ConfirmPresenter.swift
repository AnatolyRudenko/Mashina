//
//  ConfirmPresenter.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

final class ConfirmPresenter: PropertiesPresenter, ConfirmPresenterProtocol {
    
    weak var view: ConfirmViewProtocol!
    var interactor: ConfirmInteractorProtocol!
    var router: ConfirmRouterProtocol!
    
    init(view: ConfirmViewProtocol) {
        self.view = view
        super.init(localCar: self.view.localCar)
    }
    
    required init(localCar: LocalCar?) {
        fatalError("init(localCar:) has not been implemented")
    }
    
    override func applyCar() {
        super.applyCar()
        self.view.setName(super.localCar?.name ?? "Нет имени")
        self.view.setImage(super.localCar?.image)
    }
    
    func configureView(with stackView: UIStackView) {
        guard !super.visualSetupIsOver else { return }
        super.setPropertyViewsIn(stackView: stackView)
        view?.addImageView(imageView: self.createImageView())
        self.applyCar()
    }
    
    func editButtonPressed() {
        self.interactor.newCar ?
            self.router.dismiss() :
            self.router.goToEditVC(with: super.buildLocalCar())
    }
    
    func deleteButtonPressed() {
        self.interactor.delete()
        self.router.goToListVC()
    }
    
    func arrowButtonPressed(carName: String) {
        guard carName != "" else { //cant' create an unnamed car
            self.view.showPopUp(self.interactor.createPopUp())
            return
        }
        self.interactor.saveChanges(car: super.localCar)
        self.router.goToListVC()
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = FontManager.labelColor
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        return imageView
    }
}
