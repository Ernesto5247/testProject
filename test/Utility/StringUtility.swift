//
//  StringUtility.swift
//  test
//
//  Created by Ernesto Hernandez on 6/24/20.
//  Copyright © 2020 ernestoHernandez. All rights reserved.
//

import Foundation

protocol StringExtension {
    func textExists(str:String?) -> Bool
    mutating func appendStringifAvailable(str:String, toAppend:String?, preStr:String, endLine:String)
    mutating func appendStringList(str:String, toAppend:[String], preStr:String, endLine:String)
}

extension String: StringExtension {
    func textExists(str:String?) -> Bool {
        if str == nil || str?.count == 0 {
            return false
        }
        return true
    }
    mutating func appendStringifAvailable(str:String, toAppend:String?, preStr:String = "", endLine:String = "") {
        if textExists(str: toAppend) {
            self = str + "\(preStr)\(toAppend!)\(endLine)"
        }
    }
    mutating func appendStringList(str:String, toAppend:[String], preStr:String = "", endLine:String = "") {
        if toAppend.count > 0 {
            var newStr = "\(str)\(preStr)"
            for i in 0..<toAppend.count {
                if i < toAppend.count-1 { newStr = "\(newStr)\(toAppend[i]), " }
                else { newStr = "\(newStr)\(toAppend[i])\(endLine)" }
            }
            self = newStr
        }
    }
}
