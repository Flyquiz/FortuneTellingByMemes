//
//  DataStore.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 22.02.2024.
//

import Foundation

final class DataStore {
    
    static let shared = DataStore()
    
    public var memes = [Meme]() {
        didSet {
            do {
                let data = try encoder.encode(memes)
                userDefaults.setValue(data, forKey: "memes")
            } catch {
                print("Can't encode data for saving")
            }
        }
    }
    
    private let userDefaults = UserDefaults.standard
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private init() {
        guard let data = userDefaults.data(forKey: "memes") else { return }
        do {
            memes = try decoder.decode([Meme].self, from: data)
        } catch {
            print("Can't download intenral data")
        }
    }
    
    
//    public func saveMeme(_ meme: Meme) {
//        memeStorage.append(meme)
//        userDefaults.setValue(memeStorage, forKey: "memes")
//    }
//    
//    public func deleteMeme(_ meme: Meme) {
//        memeStorage.filter(meme)
//    }
}
