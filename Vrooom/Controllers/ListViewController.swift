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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.realmManager = RealmManager()
        self.setupTable()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
         self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func setupTable() {
        self.tableView.register(UINib(nibName: K.cell.nibName, bundle: nil),
                                forCellReuseIdentifier: K.cell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.realmManager?.cars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:ListCell = self.tableView.dequeueReusableCell(withIdentifier: K.cell.reuseIdentifier)
                as? ListCell else {
            return UITableViewCell()
        }
        let car = self.realmManager?.cars?[indexPath.row]
        cell.setName(car?.name ?? "Нет имени")
        let image = ImageManager().getImageFromImageName(car?.imageName)
        cell.setImage(image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OperatedCar.index = indexPath.row
        self.performSegue(withIdentifier: K.segues.fromListToConfirm, sender: nil)
    }
}
