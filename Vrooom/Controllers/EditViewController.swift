//
//  EditViewController.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    
    var carToEdit: LocalCar?
    var activeField: UITextField?
    var image: UIImage?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupPropertyViews()
    }
    
    private func setupPropertyViews() {
        guard self.stackView.arrangedSubviews.count < PropertyType.allCases.count else {
            return
        }
        for type in PropertyType.allCases {
            let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40)
            let view = CarPropertyView(frame: frame, type: type, editable: true)
            self.stackView.addArrangedSubview(view)
        }
        self.addLoadImageButton()
    }
    
    private func addLoadImageButton() {
        let button = UIButton()
        button.setTitle("Загрузить изображение", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = FontManager.customBlue.cgColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loadImagePressed), for: .touchUpInside)
        self.stackView.addArrangedSubview(button)
    }
    
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.toConfirm {
            let svc = segue.destination as! ConfirmViewController
            
//            var carToSend = LocalCar(
//            name: nameTextField.text!,
//            year: yearTextField.text!,
//            mileage: mileageTextField.text!,
//            model: modelTextField.text!,
//            bodyType: bodyTypeTextField.text!,
//            country: countryTextField.text!,
//            manufacturer: manufacturerTextField.text!
//            )
            
//            svc.carToEdit = carToSend
            svc.prepareRealm()
        }
    }
    
    func buildCar() {
        if let safeCar = carToEdit {
//            self.nameTextField.text = safeCar.name
        }
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc private func loadImagePressed() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
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

