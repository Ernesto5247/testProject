//
//  CountryTableView.swift
//  test
//
//  Created by Ernesto Hernandez on 6/23/20.
//  Copyright © 2020 ernestoHernandez. All rights reserved.
//

import Foundation
import UIKit
import SVGKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryTitle: UILabel!
    @IBOutlet weak var countryCodeTitle: UILabel!
    @IBOutlet weak var flagView: UIView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var sessionTask:URLSessionTask?

    func initWithCountry(country: Country) {
        self.sessionTask?.cancel()
        countryTitle.text = country.name
        countryCodeTitle.text = country.alpha2Code
        self.sessionTask?.cancel()
        self.flagImageView.alpha = 0
        self.loadingIndicator.startAnimating()
        
        guard let urlStr = country.flag else { return }
        guard let url = URL(string:urlStr) else { return }
        
        let strArray = urlStr.components(separatedBy: ".")
        let isSVG = strArray.last == "svg"
        
        let session = URLSession.shared
        self.sessionTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            guard let imageData = data else { return }
            var img:UIImage? = nil
            if isSVG {
                let receivedIcon: SVGKImage = SVGKImage(data: imageData);
                img = receivedIcon.uiImage
            } else {
                img = UIImage(data: imageData)
            }
            DispatchQueue.main.async {
                self.flagImageView.image = img
                UIView.animate(withDuration: 0.3) {
                    self.flagImageView.alpha = 1
                }
            }
        })
        self.sessionTask?.resume()
        
    }
}
