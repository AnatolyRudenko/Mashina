//
//  ViewController.swift
//  Vrooom
//
//  Created by Admin on 17.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var selectedIndex: Int?
    let realm = try! Realm()
    var cars: Results<RealmCar>?
    var rowHeights:[Int:CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCars()
        tableView.register(UINib(nibName: K.cell.nibName, bundle: nil), forCellReuseIdentifier: K.cell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
         self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func loadCars() {
        cars = realm.objects(RealmCar.self)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.fromListToConfirm {
            if let svc = segue.destination as? ConfirmViewController {
            OperatedCar.newCar = false
            }
        }
    }
}

    //MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListCell = self.tableView.dequeueReusableCell(withIdentifier: K.cell.reuseIdentifier) as! ListCell
        let car = cars?[indexPath.row]
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
