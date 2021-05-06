//
//  InitialViewController.swift
//  Vrooom
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

final class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = IconManager.init(dark: self.traitCollection.userInterfaceStyle == .dark)
    }
    
    @IBAction private func addButtonPressed(_ sender: UIButton) {
        OperatedCar.newCar = true
        performSegue(withIdentifier: K.segues.toEdit, sender: nil)
    }
    
    @IBAction private func listButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.segues.toList, sender: nil)
    }
}

