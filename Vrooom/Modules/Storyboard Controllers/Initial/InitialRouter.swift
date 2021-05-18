//
//  InitialRouter.swift
//  Vrooom
//
//  Created by Admin on 16.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

final class InitialRouter: InitialRouterProtocol {
    
    weak var viewController: InitialViewController!
    
    init(viewController: InitialViewController) {
        self.viewController = viewController
    }
    
    func goToEditVC() {
        guard let dvc:EditViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Edit")
                as? EditViewController else { return }
        viewController.present(dvc, animated: true, completion: nil)
    }
    
    func goToListVC() {
        guard let dvc:ListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "List")
                as? ListViewController else { return }
        let dvcInterfaceInstance = dvc as ListViewProtocol
        dvcInterfaceInstance.prepareContent()
        viewController.present(dvc, animated: true, completion: nil)
    }
}
