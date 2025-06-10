//
//  DataModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 7/5/23.
//

import Foundation

enum DataModelError: Error, LocalizedError {
    case invalidURL
    case missingAPIKey
    case decodingFailed
    case apiError
    case unknown
    
    var errorDescription: String? {
          switch self {
          case .invalidURL: return "The URL is invalid."
          case .missingAPIKey: return "API key is missing."
          case .decodingFailed: return "Failed to decode the response."
          case .apiError: return "API is having issues"
          case .unknown: return "An unknown error occurred."
          }
      }

      var recoverySuggestion: String? {
          switch self {
          case .invalidURL: return "Please check the search term."
          case .missingAPIKey: return "Check your app configuration."
          case .decodingFailed: return "Try again later."
          case .apiError: return "Try again later."
          case .unknown: return "An unknown error occurred."
          }
      }
}

@MainActor
class DataModel {    
    func fetchVerseModel(searchTerm: String) async throws -> Model? {
            guard let url = buildUrl(forTerm: searchTerm) else {
                throw DataModelError.invalidURL
            }
            
            let username = "com.edwardlie.bibleversefinder"
            guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
                throw DataModelError.missingAPIKey
            }
            
            let loginString = String(format: "\(username):\(apiKey)", username, apiKey)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            
            let headers = [
                "Authorization": "Basic \(base64LoginString)"
            ]
            
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers
            
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
//            print(String(data: data, encoding: .utf8))
            return try? JSONDecoder().decode(Model.self, from: data)
        } catch {
            throw DataModelError.decodingFailed
        }
    }
    
    func buildUrl(forTerm searchTerm: String) -> URL? {
        guard !searchTerm.isEmpty else { return nil }
        
        let queryItems = [
            URLQueryItem(name: "String", value: searchTerm),
            URLQueryItem(name: "Out", value: "json")
        ]
        
        var components = URLComponents(string: "https://api.lsm.org/recver/txo.php?")
        components?.queryItems = queryItems
        
        return components?.url
    }
}
