//
//  EditViewController.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

final class EditViewController: UIViewController, EditViewProtocol {
    
    var presenter: EditPresenterProtocol!
    let configurator: EditConfiguratorProtocol = EditConfigurator()
    var localCar: LocalCar?

    @IBOutlet private weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(with: self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.presenter.configureView(with: self.stackView)
    }
    
    func addActionToLoadImageButton(_ button: UIButton) {
        button.addTarget(self, action: #selector(loadImagePressed), for: .touchUpInside)
    }
    
    func showPopUp(_ view: PopUpView) {
        self.view.addSubview(view)
    }
    
    @IBAction func arrowPressed(_ sender: UIButton) {
        self.presenter.arrowPressed()
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc private func loadImagePressed() {
        self.presenter.setupImagePicker()
    }
    
    func presentImagePicker(_ picker: UIImagePickerController) {
        picker.delegate = self
        present(picker, animated: true, completion: nil)
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
            self.presenter.image = image
        }
    }
}

