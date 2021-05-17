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
    
}
