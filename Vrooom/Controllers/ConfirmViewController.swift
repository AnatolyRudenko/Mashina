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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var milageLabel: UILabel!
    @IBOutlet weak var bodyTypeLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var popUpView: UIView!
    
    var carToEdit: LocalCar?
    var cars: Results<RealmCar>?
    let realm = try! Realm()
    var toProceed = true
    var imagePath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCarInfo()
        popUpView.isHidden = true
    }
        
    //MARK: - Buttons functionality
    @IBAction func editButtonPressed(_ sender: UIButton) {
        if OperatedCar.newCar {
            self.dismiss(animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: K.segues.toEditFromConfirm, sender: nil)
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        toProceed = false
        performSegue(withIdentifier: K.segues.toListFromConfirm, sender: nil)
    }
    
    @IBAction func arrowPressed(_ sender: UIButton) {
        toProceed = true
        if nameLabel.text == "" { //cant' create an unnamed car
            popUpView.isHidden = false
            return
        }
        performSegue(withIdentifier: K.segues.toListFromConfirm, sender: nil)
    }
    
    //MARK: - Segue settings
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.segues.toListFromConfirm {
            if toProceed {
                let newCar = RealmCar()
                newCar.name = nameLabel.text
                newCar.year = yearLabel.text
                newCar.model = modelLabel.text
                newCar.bodyType = bodyTypeLabel.text
                newCar.mileage = milageLabel.text
                newCar.manufacturer = manufacturerLabel.text
                newCar.country = countryLabel.text
                if let newImage = carToEdit?.image {
                    saveImage(image: newImage) //save new image
                }
                newCar.imageName = imagePath
                
                if OperatedCar.newCar {
                    save(newCar) //add car
                } else {
                    edit(newCar) // edit car
                }
            } else {
                delete() //delete car
            }
            self.imagePath = nil
        }
        
        if segue.identifier == K.segues.toEditFromConfirm {
            let dvc = segue.destination as! EditViewController
            self.carToEdit = LocalCar(name: nameLabel.text ?? "", year: yearLabel.text ?? "", mileage: milageLabel.text ?? "", model: modelLabel.text ?? "", bodyType: bodyTypeLabel.text ?? "", country: countryLabel.text ?? "", manufacturer: manufacturerLabel.text ?? "")
            dvc.localCar = self.carToEdit
        }
        carToEdit = nil
    }
    
    //MARK: - Image Manager
    
    func getDocumentsURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL
    }

    func fileInDocumentsDirectory(_ filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL.path

    }

    func writeImage(_ image: UIImage, path: String ) {
        if let pngImageData = image.pngData() {
            try? pngImageData.write(to: URL(fileURLWithPath: path), options: [.atomic])
        }
    }
    
    func loadImageFromPath(_ path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("couldn't find image in comfirm at path: \(path)")
        }
        return image
    }
    
    func saveImage(image: UIImage) { //call this to save an image
        guard let name = nameLabel.text else {return}
        let imageFileName:String = "\(name).png"
        self.imagePath = fileInDocumentsDirectory(imageFileName)
        writeImage(image, path: self.imagePath!)
    }

    func getImage() -> UIImage? { //call this to get image from its path
        guard let name = nameLabel.text else {return nil}
        let imageName:String = "\(name).png"
        let imagePath = fileInDocumentsDirectory(imageName)
        if let loadedImage = self.loadImageFromPath(imagePath) {
            return loadedImage
        } else {
            print("Couldn't Load in confirm: \(imageName)")
            return nil
        }
    }

    //MARK: - Car operations
    
    func save(_ newCar: RealmCar) {
        do {
            try realm.write {
                realm.add(newCar)
            }
        } catch {
            print("error saving to realm: \(error)")
        }
    }
    
    func edit(_ newCar: RealmCar) {
        if let safeIndex = OperatedCar.index, let car = cars?[safeIndex] {
            do {
                try realm.write{
                    car.name = newCar.name
                    car.year = newCar.year
                    car.model = newCar.model
                    car.bodyType = newCar.bodyType
                    car.mileage =  newCar.mileage
                    car.manufacturer = newCar.manufacturer
                    car.country = newCar.country
                    car.imageName = newCar.imageName
                }
            } catch {
                print("Error editing car, \(error)")
            }
        }
    }
    
    func delete() {
        if OperatedCar.newCar == false {
            if let safeIndex = OperatedCar.index, let car = cars?[safeIndex] {
                do {
                    try realm.write{
                        realm.delete(car)
                    }
                } catch {
                    print("Error deleting car: \(error)")
                }
            }
        }
    }
    
    func getCarInfo() {
        
        if let carFromEdit = carToEdit { //if car has just been edited
            nameLabel.text = carFromEdit.name
            modelLabel.text = carFromEdit.model
            yearLabel.text = carFromEdit.year
            milageLabel.text = carFromEdit.mileage
            bodyTypeLabel.text = carFromEdit.bodyType
            manufacturerLabel.text = carFromEdit.manufacturer
            countryLabel.text = carFromEdit.country
            if let safeImage = carFromEdit.image {
                carImageView.image = safeImage
            }
        }
        if carToEdit == nil {
            if let safeIndex = OperatedCar.index { //if we came from ListViewController
                nameLabel.text = cars?[safeIndex].name
                modelLabel.text = cars?[safeIndex].model
                yearLabel.text = cars?[safeIndex].year
                milageLabel.text = cars?[safeIndex].mileage
                bodyTypeLabel.text = cars?[safeIndex].bodyType
                manufacturerLabel.text = cars?[safeIndex].manufacturer
                countryLabel.text = cars?[safeIndex].country
                
                imagePath = cars?[safeIndex].imageName
                
                guard let safeImageName = cars?[safeIndex].imageName else {return} //if car should have an image
                if let preloadedCarImage = UIImage(named: safeImageName) { //if car image is preloaded
                    carImageView.image = preloadedCarImage
                } else {
                    if let safeImage = getImage() { //if it's a custom car image
                        carImageView.image = safeImage
                    }
                }
            }
        }
    }
    
    //MARK: - Prepare for realm
    func prepareRealm() { // not sure if this makes any sense. The goal is to save some time loading this viewController. Gets called from "prepare for segue" from other viewControllers
        cars = realm.objects(RealmCar.self)
    }
    
    //MARK: - Dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){ //to dismiss popUpVIew
           let touch = touches.first
           if touch?.view != self.popUpView
           { self.dismiss(animated: true, completion: nil) }
    }
}

