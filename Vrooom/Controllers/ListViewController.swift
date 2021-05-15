//
//  ViewController.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var realmManager: RealmManager?
    private var cellImages: [UIImage]?
    private var cellHeights = [CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
         self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func prepareContent() {
        self.realmManager = RealmManager()
        guard let cars = self.realmManager?.cars else { return }
        let imageManager = ImageManager()
        self.cellImages = []
        for car in cars {
            let image = imageManager.getImageFromImageName(car.imageName)
            self.cellImages?.append(image)
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.fromListToConfirm,
           let dvc = segue.destination as? ConfirmViewController,
           let index = OperatedCar.index,
           let realmCar = self.realmManager?.cars?[index] {
            OperatedCar.newCar = false
            dvc.localCar = self.realmManager?.convertRealmCarToLocal(realmCar)
        }
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
        return self.realmManager?.cars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:ListCell = self.tableView.dequeueReusableCell(withIdentifier: K.cell.reuseIdentifier)
                as? ListCell else {
            return UITableViewCell()
        }
        let car = self.realmManager?.cars?[indexPath.row]
        let image = self.cellImages?[indexPath.row] ?? ImageManager().getImageFromImageName(car?.imageName)
        self.saveCellHeight(index: indexPath.row, cellHeight: cell.cellHeightWithoutImage, image: image)
        cell.setName(car?.name ?? "Нет имени")
        cell.setImage(image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OperatedCar.index = indexPath.row
        self.performSegue(withIdentifier: K.segues.fromListToConfirm, sender: nil)
    }
}
