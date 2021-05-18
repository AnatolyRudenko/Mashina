//
//  ConfirmViewController.swift
//  Vrooom
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

final class ConfirmViewController: UIViewController, ConfirmViewProtocol {
    
    var presenter: ConfirmPresenterProtocol!
    let configurator: ConfirmConfiguratorProtocol = ConfirmConfigurator()
    var localCar: LocalCar?
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    private weak var carImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(with: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.presenter.configureView(with: self.stackView)
        self.view.layoutIfNeeded()
    }
    
    func addImageView(imageView: UIImageView) {
        guard self.carImageView == nil else { return }
        self.carImageView = imageView
        self.stackView.addArrangedSubview(imageView)
    }
    
    func setName(_ text: String) {
        self.nameLabel.text = text
    }
    
    func setImage(_ image: UIImage?) {
        self.carImageView?.image = image
    }
    
    func showPopUp(_ view: PopUpView) {
        self.view.addSubview(view)
    }
    
    //MARK: - Buttons functionality
    @IBAction func editButtonPressed(_ sender: UIButton) {
        self.presenter.editButtonPressed()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.presenter.deleteButtonPressed()
    }
    
    @IBAction func arrowPressed(_ sender: UIButton) {
        self.presenter.arrowButtonPressed(carName: self.nameLabel.text ?? "")
    }
}

