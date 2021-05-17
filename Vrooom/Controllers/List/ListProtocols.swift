//
//  ListProtocols.swift
//  Vrooom
//
//  Created by Admin on 17.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

protocol ListConfiguratorProtocol: class {
    func configure(with viewController: ListViewController)
}
    
protocol ListViewProtocol: class {
    func prepareContent()
}

protocol ListPresenterProtocol: class {
    var router: ListRouterProtocol! { set get }
}

protocol ListInteractorProtocol {
    
}

protocol ListRouterProtocol: class {
    
}
