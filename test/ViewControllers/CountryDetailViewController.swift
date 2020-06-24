//
//  CountryDetailViewController.swift
//  test
//
//  Created by Ernesto Hernandez on 6/24/20.
//  Copyright © 2020 ernestoHernandez. All rights reserved.
//

import Foundation
import UIKit

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryDetailTextView: UITextView!
    
    var countryData:Country?
    var flagImage:UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        loadWithData()
    }
    func loadWithData() {
        self.flagImageView.image = flagImage
        
        guard let cData = countryData else { return }
        
        let attributedString = NSMutableAttributedString(string: "\(countryData?.name ?? "")\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        var countryDetailString = ""
        countryDetailString.appendStringList(str: countryDetailString, toAppend: cData.altSpellings ?? [], preStr:"Alternate Names: ", endLine:"\n")
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(cData.nativeName ?? "")", preStr:"Native Name: ", endLine:"\n")
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(cData.alpha2Code ?? ""), \(cData.alpha3Code ?? "")", preStr:"Country Codes: ", endLine:"\n")
        countryDetailString.appendStringList(str: countryDetailString, toAppend: cData.callingCodes ?? [], preStr:"Calling Codes: ", endLine:"\n\n")
        
        attributedString.append(NSAttributedString(string: countryDetailString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        
        countryDetailString = "Info:\n"
        
        attributedString.append(NSAttributedString(string: countryDetailString, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]))
        
        countryDetailString = ""
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(cData.region ?? "")", preStr:"Region: ", endLine:" - ")
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(cData.subregion ?? "")", preStr:"Subregion: ", endLine:"\n")
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(cData.capital ?? "")", preStr:"Capital: ", endLine:"\n")
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(cData.demonym ?? "")", preStr:"Denomination: ", endLine:"\n")
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(cData.population ?? 0)", preStr:"Population: ", endLine:"\n\n")
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "Languages:", endLine:"\n")
        if cData.languages != nil {
            for language in cData.languages! {
                countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(language.name ?? "")", preStr:"Name: ", endLine:" - ")
                countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(language.nativeName ?? "")", preStr:"Native Name: ", endLine:"\n")
                countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(language.iso639_1 ?? "")", preStr:"Symbol: ", endLine:" - ")
                countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(language.iso639_2 ?? "")", endLine:"\n")
            }
        }
        
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "Currencies:", preStr:"\n", endLine:"\n")
        if cData.currencies != nil {
            for curr in cData.currencies! {
                countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(curr.name ?? "")", preStr:"Name: ", endLine:" - ")
                countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(curr.code ?? "")", preStr:"Code: ", endLine:"\n")
                countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(curr.symbol ?? "")", preStr:"Symbol: ", endLine:"\n\n")
            }
        }
        
        attributedString.append(NSAttributedString(string: countryDetailString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        
        countryDetailString = "Geographic Info:\n"
        
        attributedString.append(NSAttributedString(string: countryDetailString, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]))
        
        countryDetailString = ""
        if cData.latlng?.count == 2 {
            countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "Latitude \(cData.latlng![0]) , Longitude: \(cData.latlng![1])", endLine:"\n")
        }
        countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(cData.area ?? 0)", preStr:"Area: ", endLine:" km2\n\n")
        countryDetailString.appendStringList(str: countryDetailString, toAppend: cData.timezones ?? [], preStr:"Time Zones: ", endLine:"\n\n")
        countryDetailString.appendStringList(str: countryDetailString, toAppend: cData.borders ?? [], preStr:"Borders: ", endLine:"\n\n")
        
        attributedString.append(NSAttributedString(string: countryDetailString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        
        countryDetailString = "Regional Bloc:\n"
        
        attributedString.append(NSAttributedString(string: countryDetailString, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]))
        
        countryDetailString = ""
        
        if cData.regionalBlocs != nil {
            for bloc in cData.regionalBlocs! {
                countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(bloc.name ?? "")", preStr:"Name: ", endLine:"\n")
                if bloc.otherNames != nil && bloc.otherNames!.count > 0 {
                    countryDetailString.appendStringList(str: countryDetailString, toAppend: bloc.otherNames!, preStr:"Other Names: ", endLine:"\n")
                }
                countryDetailString.appendStringifAvailable(str: countryDetailString, toAppend: "\(bloc.acronym ?? "")", preStr:"Acronym: ", endLine:"\n")
                if bloc.otherAcronyms != nil && bloc.otherAcronyms!.count > 0 {
                    countryDetailString.appendStringList(str: countryDetailString, toAppend: bloc.otherAcronyms!, preStr:"Other Acronyms", endLine:"\n")
                }
            }
        }
        
        if countryDetailString.count == 0 {
            countryDetailString = "None"
        }
        
        attributedString.append(NSAttributedString(string: countryDetailString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        
        countryDetailTextView.attributedText = attributedString
    }
    
}
