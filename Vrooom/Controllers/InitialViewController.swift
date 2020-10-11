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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if UserDefaults.isFirstLaunch() {
//            let realm = try! Realm()
////            var cars: Results<CarList>?
//            let cars = realm.objects(CarList.self)
//            let carImages: [UIImage]
//            for index in 0...cars.count-1 {
//                let image = UIImage(named: (cars[index].imageName!))
//                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
//            }
//        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        OperatedCar.newCar = true
        performSegue(withIdentifier: K.segues.toEdit, sender: nil)
    }
    
    @IBAction func listButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.segues.toList, sender: nil)
    }
}

