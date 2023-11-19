//
//  File.swift
//  
//
//  Created by Anna Sumire on 19.11.23.
//

import Foundation

public final class FactService {
    static let shared = FactService ()
    
    public init() {}
    
    func fetchFacts(completion: @escaping (Result<[Fact], Error>) -> Void) {
        let urlStr = "https://catfact.ninja/facts?limit=20"
        
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure (error))
                return
            }
            
            guard let data = data else {
                completion (. failure (NSError (domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received" ])))
                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(FactModel.self, from: data)
                completion(.success (moviesResponse.data))
            } catch {
                completion(.failure (error))
            }
        }.resume ()
    }
    
    func downloadImage (from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlString)") else {
            completion (nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage (data: data) else {
                completion (nil)
                return
            }
            
            completion(image)
        }.resume()
    }
}
