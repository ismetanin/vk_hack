//
//  KeychainStorage.swift
//  InSearch
//
//  Created by Ivan Smetanin on 20/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Locksmith

final class KeychainStorage: KeychainStorable {

    func save(data: [String: Any], forUserAccount userAccount: String) throws {
        try Locksmith.updateData(data: data, forUserAccount: userAccount)
    }

    func loadData(forUserAccount userAccount: String) -> [String: Any]? {
        return Locksmith.loadDataForUserAccount(userAccount: userAccount)
    }

    func loadData<DataType>(forUserAccount userAccount: String, byKey key: String) -> DataType? {
        if let dictionary = Locksmith.loadDataForUserAccount(userAccount: userAccount),
            let data = dictionary[key] as? DataType {
            return data
        } else {
            return nil
        }
    }

    func deleteData(forUserAccount userAccount: String) throws {
        try Locksmith.deleteDataForUserAccount(userAccount: userAccount)
    }
    
}
