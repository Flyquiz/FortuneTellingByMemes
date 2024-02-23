//
//  DataStore.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 22.02.2024.
//

import Foundation

final class DataStore {
    
    static let shared = DataStore()
    
    private var memeStorage = [Meme]()
    
    private let userDefaults = UserDefaults.standard
    
    private let decoder = JSONDecoder()
    
    
    private init() {
        guard let data = userDefaults.data(forKey: "memes") else { return }
        do {
            memeStorage = try decoder.decode([Meme].self, from: data)
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
