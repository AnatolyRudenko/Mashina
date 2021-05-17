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
    
    func goToEditVC(on view: InitialViewProtocol) {
        let dvc:EditViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Edit") as! EditViewController
        viewController.present(dvc, animated: true, completion: nil)
    }
    
    func goToListVC(on view: InitialViewProtocol) {
        let dvc:ListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "List") as! ListViewController
        dvc.prepareContent()
        viewController.present(dvc, animated: true, completion: nil)
    }
}
