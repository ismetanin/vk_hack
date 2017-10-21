//
//  KeychainStorable.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

protocol KeychainStorable {
    func save(data: [String: Any], forUserAccount userAccount: String) throws
    func loadData(forUserAccount userAccount: String) -> [String: Any]?
    func loadData<DataType>(forUserAccount userAccount: String, byKey key: String) -> DataType?
    func deleteData(forUserAccount userAccount: String) throws
}
