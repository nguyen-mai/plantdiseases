//
//  DiseasesListViewController.swift
//  PlantDiseases
//
//  Created by Apple on 2021/10/15.
//

import UIKit

class DiseasesListViewController: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    let names = ["Peper Bell Baterial Spot", "Potato Early Blight", "Potato Late Blight", "Tomato Bacterial Spot", "Tomato Early Blight", "Tomato Late Blight", "Tomato Leaf Mold", "Tomato Target Spot"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.text = "Search".localized()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search here...".localized()
        configTable()
    }
    
    func configTable() {
        table.delegate = self
        table.dataSource = self
    }
}

extension DiseasesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListViewCell
        cell.img.image = UIImage(named: names[indexPath.row])
        cell.diseaseName.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailDiseaseViewController") as? DetailDiseaseViewController {
            vc.img = UIImage(named: names[indexPath.row])!
            vc.lbl = names[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
