//
//  testTests.swift
//  testTests
//
//  Created by Ernesto Hernandez on 6/22/20.
//  Copyright © 2020 ernestoHernandez. All rights reserved.
//

import XCTest
@testable import test

class testTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidJSON() throws {
        var path = Bundle.main.path(forResource: "validJSON", ofType: "json")!
        do {
            let jsonData = try String(contentsOfFile: path, encoding: .utf8).data(using: .utf8)!
            XCTAssertNoThrow(try JSONDecoder().decode([Country].self, from: jsonData))
        }
        path = Bundle.main.path(forResource: "validJSONMissingKeys", ofType: "json")!
        do {
            let jsonData = try String(contentsOfFile: path, encoding: .utf8).data(using: .utf8)!
            XCTAssertNoThrow(try JSONDecoder().decode([Country].self, from: jsonData))
        }
    }
    func testInvalidJSON() throws {
        let path = Bundle.main.path(forResource: "invalidJSON", ofType: "json")!
        do {
            let jsonData = try String(contentsOfFile: path, encoding: .utf8).data(using: .utf8)!
            XCTAssertThrowsError(try JSONDecoder().decode([Country].self, from: jsonData))
        }
    }
    func testStringUtility() throws {
        var str = "String 1"
        let strList = ["aaa","bbb","ccc","ddd"]
        str.appendStringifAvailable(str: str, toAppend: "String 2", preStr: " - Pre - ", endLine: " - Post")
        XCTAssert(str == "String 1 - Pre - String 2 - Post")
        str = "String 1"
        str.appendStringifAvailable(str: str, toAppend: "String 2", endLine: " - Post")
        XCTAssert(str == "String 1String 2 - Post")
        str = "String 1"
        str.appendStringifAvailable(str: str, toAppend: "String 2")
        XCTAssert(str == "String 1String 2")
        str = "String 1"
        str.appendStringList(str: str, toAppend: strList, preStr: " - Pre - ", endLine: " - Post")
        XCTAssert(str == "String 1 - Pre - aaa, bbb, ccc, ddd - Post")
        str = "String 1"
        str.appendStringList(str: str, toAppend: strList, endLine: " - Post")
        XCTAssert(str == "String 1aaa, bbb, ccc, ddd - Post")
        str = "String 1"
        str.appendStringList(str: str, toAppend: strList)
        XCTAssert(str == "String 1aaa, bbb, ccc, ddd")
    }

}
