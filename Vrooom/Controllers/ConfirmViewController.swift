//
//  ConfirmViewController.swift
//  Vrooom
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit
import RealmSwift

class ConfirmViewController: PropertiesViewController {
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var carImageView: UIImageView!
    weak var popUpView: UIView!
    
    private var shouldSave = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.editable = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        super.setPropertyViewsIn(stackView: self.stackView)
        self.applyCar()
    }
    
    override func setPropertyViewsIn(stackView: UIStackView) {
//        self.stackView
        super.setPropertyViewsIn(stackView: stackView)
    }
        
    override func applyCar() {
        super.applyCar()
        self.nameLabel.text = super.localCar?.name
        self.carImageView.image = super.localCar?.image
    }
    
    //MARK: - Buttons functionality
    @IBAction func editButtonPressed(_ sender: UIButton) {
        OperatedCar.newCar ?
            self.dismiss(animated: true, completion: nil) :
            performSegue(withIdentifier: K.segues.toEditFromConfirm, sender: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.shouldSave = false
        performSegue(withIdentifier: K.segues.toListFromConfirm, sender: nil)
    }
    
    @IBAction func arrowPressed(_ sender: UIButton) {
        guard self.nameLabel.text != "" else { //cant' create an unnamed car
//            popUpView.isHidden = false
            return
        }
        self.shouldSave = true
        performSegue(withIdentifier: K.segues.toListFromConfirm, sender: nil)
    }
    
    //MARK: - Segue settings
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.segues.toListFromConfirm {
            if self.shouldSave {
                OperatedCar.newCar ?
                    RealmManager().save(super.localCar) : // add car
                    RealmManager().edit(super.localCar) // edit car
            } else {
                RealmManager().delete() //delete car
            }
        }
        
        if segue.identifier == K.segues.toEditFromConfirm {
            let dvc = segue.destination as? EditViewController
            dvc?.localCar = super.buildLocalCar()
        }
    }
    
    //MARK: - Dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //to dismiss popUpVIew
        let touch = touches.first
        if touch?.view != self.popUpView {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

