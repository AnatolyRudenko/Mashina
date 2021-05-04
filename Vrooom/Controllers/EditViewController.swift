//
//  EditViewController.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

class EditViewController: PropertiesViewController {

    @IBOutlet private weak var stackView: UIStackView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.editable = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        super.setPropertyViewsIn(stackView: self.stackView)
        self.addLoadImageButton()
    }
    
    private func addLoadImageButton() {
        guard self.stackView.arrangedSubviews.count == PropertyType.allCases.count else { return }
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
            let dvc = segue.destination as? ConfirmViewController
            dvc?.localCar = super.buildLocalCar()
        }
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc private func loadImagePressed() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
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

