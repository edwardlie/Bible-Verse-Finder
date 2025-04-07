//
//  DataModel.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 7/5/23.
//

import Foundation

class DataModel {
    private var dataTask: URLSessionDataTask?
    func loadVerses(searchTerm: String, completion: @escaping(([Verse]) -> Void)) {
        dataTask?.cancel()
        guard let url = buildUrl(forTerm: searchTerm) else {
            completion([])
            return
        }
        
        let username = "com.edwardlie.bibleversefinder"
        let password = "ios_5c95c579-dd75-4516-9bc1-e7e94d697f82"
        let loginString = String(format: "\(username):\(password)", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = [
            "Authorization": "Basic \(base64LoginString)"
        ]
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        dataTask = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion([])
                return
            }
            
            if let verseResponse = try? JSONDecoder().decode(Model.self, from: data) {
                completion(verseResponse.verses)
            }
        }
        dataTask?.resume()
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
