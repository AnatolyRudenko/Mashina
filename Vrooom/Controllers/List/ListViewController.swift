//
//  ViewController.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController, ListViewProtocol {
    
    var presenter: ListPresenterProtocol!
    let configurator: ListConfiguratorProtocol = ListConfigurator()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        self.presenter.backButtonPressed()
    }
    
    func prepareContent() {
        configurator.configure(with: self)
        presenter.prepareCellImages()
    }
    
    func setupTable() {
        self.tableView.register(UINib(nibName: K.cell.nibName, bundle: nil),
                                forCellReuseIdentifier: K.cell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
}

    //MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard self.presenter.cellHeights.count > indexPath.row else {
            return UITableView.automaticDimension
        }
        return self.presenter.cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.dbCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:ListCell = self.tableView.dequeueReusableCell(withIdentifier: K.cell.reuseIdentifier)
                as? ListCell else {
            return UITableViewCell()
        }
        let car = self.presenter.dbCars[indexPath.row]
        let image = self.presenter.cellImages[indexPath.row]
        self.presenter.saveCellHeight(index: indexPath.row, cellHeight: cell.cellHeightWithoutImage, imageSize: image.size)
        cell.setName(car.name ?? "Нет имени")
        cell.setImage(image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.carCellTapped(index: indexPath.row)
    }
}
