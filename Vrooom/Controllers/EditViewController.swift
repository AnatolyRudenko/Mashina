//
//  EditViewController.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var mileageTextField: UITextField!
    @IBOutlet weak var bodyTypeTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var carToEdit: LocalCar?
    var activeField: UITextField?
    var image: UIImage?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildCar()
        delegateTextFields()
        registerForKeyboardNotifications()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func loadImagePressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.toConfirm {
            let svc = segue.destination as! ConfirmViewController
            
            var carToSend = LocalCar(
            name: nameTextField.text!,
            year: yearTextField.text!,
            mileage: mileageTextField.text!,
            model: modelTextField.text!,
            bodyType: bodyTypeTextField.text!,
            country: countryTextField.text!,
            manufacturer: manufacturerTextField.text!
            )
            
            if let safeImage = self.image {
                carToSend.image = safeImage
            }
            
            svc.carToEdit = carToSend
            svc.prepareRealm()
            deregisterFromKeyboardNotifications()
        }
    }
    func buildCar() {
        if let safeCar = carToEdit {
            self.nameTextField.text = safeCar.name
            self.modelTextField.text = safeCar.model
            self.yearTextField.text = safeCar.year
            self.mileageTextField.text = safeCar.mileage
            self.bodyTypeTextField.text = safeCar.bodyType
            self.manufacturerTextField.text = safeCar.manufacturer
            self.countryTextField.text = safeCar.country
        }
    }
    func delegateTextFields() {
        self.nameTextField.delegate = self
        self.modelTextField.delegate = self
        self.yearTextField.delegate = self
        self.mileageTextField.delegate = self
        self.bodyTypeTextField.delegate = self
        self.manufacturerTextField.delegate = self
        self.countryTextField.delegate = self
    }
    
    //MARK: - Keyboard Manager
    //scrolls view up if keyboard should cover an operated textField
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height + 80, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets

        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height + 80
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
}

    //MARK: - UITextFieldDelegate
extension EditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)

            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image.pngData()! as NSData
            data.write(toFile: localPath!, atomically: true)
            _ = URL.init(fileURLWithPath: localPath!)

        }
        
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
        }
    }
}

