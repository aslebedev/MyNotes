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
    
    init() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.items = self.loadFromFile()
        }
    }
    
    //  MARK: - Mutating methods
    
    func addItem(_ item: Note) {
        items.append(item)
        saveToFile()
    }
    
    func removeItem(at index: Int) {
        items.remove(at: index)
        saveToFile()
    }
    
    func removeItem(_ item: Note) {
        items.remove(item)
        saveToFile()
    }

    //  MARK: - Private methods
    
    ///  Load from disk
    private func loadFromFile() -> [Note] {
        let filename = FileManager.getDocumentsDirectory().appendingPathComponent("SavedMyNotes")

        if let data = try? Data(contentsOf: filename) {
            if let decoded = try? JSONDecoder().decode([Note].self, from: data) {
                return decoded
            }
        }
        
        print("Unable to load saved data from disk")
        return []
    }
    
    ///  Save to disk
    private func saveToFile() {
        do {
            let filename = FileManager.getDocumentsDirectory().appendingPathComponent("SavedMyNotes")
            let data = try JSONEncoder().encode(items)

            //  Write with protect
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
