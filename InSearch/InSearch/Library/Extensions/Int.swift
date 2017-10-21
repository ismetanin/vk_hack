//
//  String.swift
//  InSearch
//
//  Created by Ivan Smetanin on 21/10/2017.
//  Copyright © 2017 9th Bit. All rights reserved.
//

import Foundation

extension Int {
    
    /// This method is used to get correct declension of word for some number.
    ///
    /// Example:
    ///
    /// getWordForPluralNumber(pluralNumber: 3, words: [День, Дня, Дней]) returns "Дня".
    /// - Parameters:
    ///   - number: The number to which you want to find the declination.
    ///   - words: An array of word declinations. Should consist of three elements where:
    ///         * 1-th element is the word nominative case in the singular
    ///         * 2-th element is the word genitive in the singular
    ///         * 3-th element is the word genitive in the plural
    /// - Returns: Returns a word from the words array in the right form.
    func getWordForPluralNumber(with words: [String]) -> String {
        var cnt = self
        if (cnt > 0) {
            if (cnt > 10 && cnt < 20) {
                return words[2]
            }
            if (cnt % 100 > 0) {
                cnt = cnt % 100
                if (cnt > 10 && cnt < 20) {
                    return words[2]
                }
            }
            cnt = cnt % 10
            if (cnt == 1) {
                return words[0]
            } else if (cnt < 5 && cnt > 0) {
                return words[1]
            } else {
                return words[2]
            }
        } else {
            return words[2]
        }
    }
}
