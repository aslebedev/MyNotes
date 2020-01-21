//
//  Notes.swift
//  MyNotes
//
//  Created by alexander on 21.01.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

class Notes {
    private(set) var items = [Note]()
    
    func addItem(_ item: Note) {
        items.append(item)
    }
    
    func removeItem(at index: Int) {
        items.remove(at: index)
    }
    
    func removeItem(_ item: Note) {
        items.remove(item)
    }
}
