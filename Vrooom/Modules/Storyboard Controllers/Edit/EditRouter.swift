//
//  EditRouter.swift
//  Vrooom
//
//  Created by Admin on 18.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

final class EditRouter: EditRouterProtocol {
    
    weak var viewController: EditViewController!
    
    init(viewController: EditViewController) {
        self.viewController = viewController
    }
    
    func goToConfirmVC(with localCar: LocalCar) {
        guard let dvc:ConfirmViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Confirm")
                as? ConfirmViewController else { return }
        let dvcInterfaceInstance = dvc as ConfirmViewProtocol
        dvcInterfaceInstance.localCar = localCar
        viewController.present(dvc, animated: true, completion: nil)
    }
}
