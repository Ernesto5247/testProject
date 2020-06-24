//
//  ViewController.swift
//  test
//
//  Created by Ernesto Hernandez on 6/22/20.
//  Copyright © 2020 ernestoHernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var countryResults: [Country] = []
    var urlSessionTask: URLSessionTask?
    var currentCountryIndex:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        tableView.alpha = 0
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        urlSessionTask?.cancel()
        
        let session = URLSession.shared
        let url = URL(string: "https://restcountries.eu/rest/v2/name/\(searchText)")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
                print(error!)
                return
            }
            guard let jsonData = data else { return }
            do {
                self.countryResults = try JSONDecoder().decode([Country].self, from: jsonData)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if self.countryResults.count > 0 {
                        self.tableView.alpha = 1
                    } else {
                        self.tableView.alpha = 0
                    }
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.countryResults = []
                    self.tableView.reloadData()
                    self.tableView.alpha = 0
                }
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.currentCountryIndex = indexPath
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryResults.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
    if indexPath.row < self.countryResults.count {
        cell.initWithCountry(country: self.countryResults[indexPath.row])
    }
    return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        guard let index = self.currentCountryIndex else { return }
        let cell = self.tableView.cellForRow(at: index) as! CountryTableViewCell
        if segue.identifier == "CountryDetail", let countryDetailVC = segue.destination as? CountryDetailViewController {
            countryDetailVC.flagImage = cell.flagImageView.image
            countryDetailVC.countryData = self.countryResults[index.row]
      }
    }
}

