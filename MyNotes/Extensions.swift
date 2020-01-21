//
//  Extensions.swift
//  MyNotes
//
//  Created by alexander on 21.01.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

//    MARK: Remove element from Array
extension Array where Element: Equatable {
    /// Remove first collection element that is equal to the given `object`:
    mutating func remove(_ object: Element) {
        guard let index = firstIndex(of: object) else { return }
        remove(at: index)
    }
}
