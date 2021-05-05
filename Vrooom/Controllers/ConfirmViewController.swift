//
//  ConfirmViewController.swift
//  Vrooom
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

class ConfirmViewController: PropertiesViewController {
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private weak var carImageView: UIImageView?
    private var shouldSave = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.editable = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.visualSetup()
    }
    
    private func visualSetup() {
        guard stackView.arrangedSubviews.count < PropertyType.allCases.count else {
            return
        }
        super.setPropertyViewsIn(stackView: self.stackView)
        self.addImageView()
        self.applyCar()
    }
        
    private func addImageView() {
        guard self.carImageView == nil else { return }
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        self.carImageView = imageView
        self.stackView.addArrangedSubview(imageView)
    }
    
    override func applyCar() {
        super.applyCar()
        self.nameLabel.text = super.localCar?.name
        self.carImageView?.image = super.localCar?.image
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
            _ = PopUpView(text: "Что же это за машина без имени?",
                          parentView: self.view)
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
}

