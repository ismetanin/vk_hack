//
//  UserListUserListMappingTests.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import InSearch

class UserListMappingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testEntityToJson() {
        // given
        <#code#>
        // when
        <#code#>
        // then
        <#code#>
    }

    func testValidJsonToEntity() {
        // given
        let json = self.generateValidJson()
        // when
        <#code#>
        // then
        <#code#>
    }

    func testInvalidJsonToEntity() {
        // given
        let json = self.generateInvalidJson()
        // when
        <#code#>
        // then
        <#code#>
    }
}

extension UserListMappingTests {

    func generateInvalidJson() -> [String: Any] {
        <#code#>
    }

    func generateValidJson() -> [String:Any] {
        <#code#>
    }
}