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
    
    private var database: DatabaseProtocol?
    private var cellHeights = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
         
    }
    
    func prepareContent() {
        configurator.configure(with: self)
        presenter.prepareContent()
    }
    
    private func setupTable() {
        self.tableView.register(UINib(nibName: K.cell.nibName, bundle: nil),
                                forCellReuseIdentifier: K.cell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    private func saveCellHeight(index: Int, cellHeight: CGFloat, image: UIImage) {
        guard self.cellHeights.count == index,
              UIScreen.main.bounds.width == image.size.width
              else { return }
        let height = cellHeight + image.size.height
        self.cellHeights.append(height)
    }
}

    //MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard self.cellHeights.count > indexPath.row else {
            return UITableView.automaticDimension
        }
        return self.cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.database?.cars.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:ListCell = self.tableView.dequeueReusableCell(withIdentifier: K.cell.reuseIdentifier)
                as? ListCell else {
            return UITableViewCell()
        }
        let car = self.database?.cars[indexPath.row]
        let image = self.cellImages?[indexPath.row] ?? ImageManager().getImageFromImageName(car?.imageName)
        self.saveCellHeight(index: indexPath.row, cellHeight: cell.cellHeightWithoutImage, image: image)
        cell.setName(car?.name ?? "Нет имени")
        cell.setImage(image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.carCellTapped(index: indexPath.row)
    }
}
