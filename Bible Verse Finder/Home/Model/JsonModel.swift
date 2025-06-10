//
//  JsonModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 7/5/23.
//

import Foundation
@preconcurrency import SwiftData

struct Model: Codable, Sendable {
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

struct Verse: Codable, Identifiable, Equatable, Sendable {
    var id = UUID()
    var ref: String
    var text: String
    var urlpfx: String
    
    enum CodingKeys: CodingKey {
      case ref, text, urlpfx
    }
    
    init(
        ref: String,
        text: String,
        urlpfx: String
    ) {
        self.ref = ref
        self.text = text
        self.urlpfx = urlpfx
    }
    
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.ref = try container.decode(String.self, forKey: .ref)
      self.text = try container.decode(String.self, forKey: .text)
      self.urlpfx = try container.decode(String.self, forKey: .urlpfx)
    }
    
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(ref, forKey: .ref)
      try container.encode(text, forKey: .text)
      try container.encode(urlpfx, forKey: .urlpfx)
    }
}
