//
//  ListRouter.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

class ListRouter: ListRouterProtocol {
    
    weak var viewController: ListViewController!
    
    init(viewController: ListViewController) {
        self.viewController = viewController
    }
    
    func goBack() {
        viewController.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func goToConfirmVC(from view: ListViewProtocol, with localCar: LocalCar) {
        guard let dvc:ConfirmViewController = UIStoryboard(name: "Main",
                                                           bundle: nil).instantiateViewController(withIdentifier: "Confirm")
                as? ConfirmViewController else { return }
        let dvcInterfaceInstance = dvc as ConfirmViewProtocol
        dvcInterfaceInstance.localCar = localCar
        viewController.present(dvc, animated: true, completion: nil)
    }
}
