import Foundation

public class FactService {
    public struct FactModel: Decodable {
        let data: [Fact]
    }
    
    public struct Fact: Decodable {
        let fact: String
    }
    
    
    public static let shared = FactService ()
    
    public init() {}
    
    public func fetchFacts(completion: @escaping (Result<[Fact], Error>) -> Void) {
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
                let factResponse = try JSONDecoder().decode(FactModel.self, from: data)
                completion(.success (factResponse.data))
            } catch {
                completion(.failure (error))
            }
        }.resume ()
    }
}
