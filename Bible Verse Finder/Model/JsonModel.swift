//
//  JsonModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 7/5/23.
//

import Foundation

struct Model: Codable {
    let inputstring, detected: String
    var verses: [Verse]
    let message, copyright: String
    
    init() {
        inputstring = ""
        detected = ""
        message = ""
        copyright = ""
        verses = []
    }
}

struct Verse: Codable, Identifiable, Equatable {
    let id = UUID()
    let ref: String
    let text: String
    let urlpfx: String
}
