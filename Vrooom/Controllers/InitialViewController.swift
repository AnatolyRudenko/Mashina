//
//  InitialViewController.swift
//  Vrooom
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit
import RealmSwift

class InitialViewController: UIViewController {
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        OperatedCar.newCar = true
        performSegue(withIdentifier: K.segues.toEdit, sender: nil)
    }
    
    @IBAction func listButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.segues.toList, sender: nil)
    }
}

