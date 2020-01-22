//
//  Note.swift
//  MyNotes
//
//  Created by alexander on 21.01.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

class Note: Equatable, Codable {
    
    let id = UUID()
    
    private(set) var text: String
    
    var title: String {
        if let firstNotEmptyString = text.components(separatedBy: "\n").first(where: { !$0.isEmpty }) {
            return firstNotEmptyString
        } else {
            return ""
        }
    }
    
    var subTitle: String {
        if let secondNotEmptyString = text.components(separatedBy: "\n").filter( { !$0.isEmpty } ).dropFirst().first {
            return secondNotEmptyString
        } else {
            return ""
        }
    }
    
    //  MARK: - Initializer
    
    init () {
        self.text = ""
    }
    
   //  MARK: - Mutating methods
    
    func changeText(newText: String) {
        self.text = newText
    }
    
    //  MARK: - Equatable implementation
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
    

}
