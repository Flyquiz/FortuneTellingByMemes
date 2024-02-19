//
//  NetworkManager.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 19.02.2024.
//

import UIKit

enum NetworkError: Error {
    case decodingError
    case noData
    
    var title: String {
        switch self {
            case .decodingError:
            return "Can't decode data"
            case .noData:
            return "Can't fetch data"
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL: URL = URL(string: "https://api.imgflip.com/get_memes")!
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private init() {}
    
    
    public func fetchMemes(completion: @escaping (Result<[Meme], NetworkError>) -> ()) {
        URLSession.shared.dataTask(with: URLRequest(url: baseURL)) { data, _, error in
            
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                sendFailure(with: .noData)
                return
            }
            
            do {
                let memesQuery = try self.decoder.decode(MemeQuery.self, from: data)
                completion(.success(memesQuery.data.memes))
                
            } catch {
                sendFailure(with: .decodingError)
            }
            
            func sendFailure(with error: NetworkError) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
