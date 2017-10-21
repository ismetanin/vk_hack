//
//  Array.swift
//  InSearch
//
//  Created by Ivan Smetanin on 22/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

extension Array {

    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }

    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }

    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        let count = self.count
        indices.dropLast().forEach {
            guard case let index = Int(arc4random_uniform(UInt32(count - $0))) + $0, index != $0 else { return }
            swap(&self[$0], &self[index])
        }
        return self
    }


    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}
