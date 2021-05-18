//
//  ConfirmRouter.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

final class ConfirmRouter: ConfirmRouterProtocol {
    
    
    
    weak var viewController: ConfirmViewController!
    
    init(viewController: ConfirmViewController) {
        self.viewController = viewController
    }
    
    func goToEditVC(with localCar: LocalCar) {
        guard let dvc:EditViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Edit") as? EditViewController else { return }
        let dvcInterfaceInstance = dvc as EditViewProtocol
        dvcInterfaceInstance.localCar = localCar
        viewController.present(dvc, animated: true, completion: nil)
    }
    
    func goToListVC() {
        guard let dvc:ListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "List") as? ListViewController else { return }
        let dvcInterfaceInstance = dvc as ListViewProtocol
        dvcInterfaceInstance.prepareContent()
        viewController.present(dvc, animated: true, completion: nil)
    }
    
    func dismiss() {
        self.viewController.dismiss(animated: true, completion: nil)
    }
}
