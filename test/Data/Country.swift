//
//  Country.swift
//  test
//
//  Created by Ernesto Hernandez on 6/23/20.
//  Copyright © 2020 ernestoHernandez. All rights reserved.
//

import Foundation
import UIKit

class Country: Codable {
    var name: String?
    var altSpellings: [String]?
    var alpha2Code: String?
    var alpha3Code: String?
    var callingCodes: [String]?
    
    var capital: String?
    var region: String?
    var subregion: String?

    var demonym: String?
    var population: Double?

    var area: Double?
    var latlng: [Double]?
    var nativeName: String?

    var timezones: [String]?
    var borders: [String]?
    
    var currencies: [Currency]?
    var languages: [Language]?
    var flag: String?
    
    var regionalBlocs: [RegionalBloc]?
    
    enum CodingKeys: CodingKey {
        case name
        case altSpellings
        case alpha2Code
        case alpha3Code
        case callingCodes
        
        case capital
        case region
        case subregion
        
        case demonym
        case population
        
        case area
        case latlng
        case nativeName
        
        case timezones
        case borders
        
        case currencies
        case languages
        case flag
        
        case regionalBlocs
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.allKeys.contains(.name) { name = try container.decode(String?.self, forKey: .name) }
        if container.allKeys.contains(.altSpellings) { altSpellings = try container.decode([String]?.self, forKey: .altSpellings) }
        if container.allKeys.contains(.alpha2Code) { alpha2Code = try container.decode(String?.self, forKey: .alpha2Code) }
        if container.allKeys.contains(.alpha3Code) { alpha3Code = try container.decode(String?.self, forKey: .alpha3Code) }
        if container.allKeys.contains(.callingCodes) { callingCodes = try container.decode([String]?.self, forKey: .callingCodes) }
        
        if container.allKeys.contains(.capital) { capital = try container.decode(String?.self, forKey: .capital) }
        if container.allKeys.contains(.region) { region = try container.decode(String?.self, forKey: .region) }
        if container.allKeys.contains(.subregion) { subregion = try container.decode(String?.self, forKey: .subregion) }
        
        if container.allKeys.contains(.demonym) { demonym = try container.decode(String?.self, forKey: .demonym) }
        if container.allKeys.contains(.population) { population = try container.decode(Double?.self, forKey: .population) }
        
        if container.allKeys.contains(.area) { area = try container.decode(Double?.self, forKey: .area) }
        if container.allKeys.contains(.latlng) { latlng = try container.decode([Double]?.self, forKey: .latlng) }
        if container.allKeys.contains(.nativeName) { nativeName = try container.decode(String?.self, forKey: .nativeName) }
        
        if container.allKeys.contains(.timezones) { timezones = try container.decode([String]?.self, forKey: .timezones) }
        if container.allKeys.contains(.borders) { borders = try container.decode([String]?.self, forKey: .borders) }
        
        if container.allKeys.contains(.currencies) { currencies = try container.decode([Currency]?.self, forKey: .currencies) }
        if container.allKeys.contains(.languages) { languages = try container.decode([Language]?.self, forKey: .languages) }
        if container.allKeys.contains(.flag) { flag = try container.decode(String?.self, forKey: .flag) }
        
        if container.allKeys.contains(.regionalBlocs) { regionalBlocs = try container.decode([RegionalBloc]?.self, forKey: .regionalBlocs) }
    }
}
