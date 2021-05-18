//
//  InitialViewController.swift
//  Vrooom
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

final class InitialViewController: UIViewController, InitialViewProtocol {
    
    var presenter: InitialPresenterProtocol!
    let configurator: InitialConfiguratorProtocol = InitialConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        self.presenter.switchIconIfNeeded(darkTheme: self.darkTheme)
    }
    
    private var darkTheme: Bool {
        if #available(iOS 12.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }
    
    @IBAction private func addButtonPressed(_ sender: UIButton) {
        self.presenter.addButtonClicked()
    }
    
    @IBAction private func listButtonPressed(_ sender: UIButton) {
        self.presenter.listButtonClicked()
    }
}

