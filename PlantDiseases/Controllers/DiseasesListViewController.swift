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
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.text = "Search".localized()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search here...".localized()
        
        filteredData = names
        
        configTable()
    }
    
    func configTable() {
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
    }
}

extension DiseasesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListViewCell
        cell.img.image = UIImage(named: filteredData[indexPath.row])
        cell.diseaseName.text = filteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailDiseaseViewController") as? DetailDiseaseViewController {
            vc.img = UIImage(named: filteredData[indexPath.row])!
            vc.lbl = filteredData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DiseasesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = names
        }
        else {
            for name in names {
                if name.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(name)
                }
            }
            
        }
        self.table.reloadData()
    }
}
