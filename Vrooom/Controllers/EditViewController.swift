//
//  EditViewController.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

final class EditViewController: PropertiesViewController {

    @IBOutlet private weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.editable = true
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
        self.addLoadImageButton()
        self.moveButtonToBottom()
        super.applyCar()
    }
    
    private func moveButtonToBottom() {
        let buttonView = self.stackView.arrangedSubviews[0]
        self.stackView.removeArrangedSubview(buttonView)
        self.stackView.addArrangedSubview(buttonView)
    }
    
    private func addLoadImageButton() {
        let button = UIButton()
        button.setTitle("Загрузить изображение", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = FontManager.customBlue?.cgColor
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
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            _ = PopUpView(text: K.strings.libraryAccessDenied,
                          parentView: self.view)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
               let data = image.pngData() as? NSData,
               let localPath = documentDirectory?.appending(imgName) {
                data.write(toFile: localPath, atomically: true)
                _ = URL.init(fileURLWithPath: localPath)
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
        }
    }
}

