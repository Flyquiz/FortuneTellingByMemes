//
//  Model.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 19.02.2024.
//

import Foundation

struct MemeQuery: Decodable {
    let data: DataQuery
}

struct DataQuery: Decodable {
    let memes: [Meme]
}

struct Meme: Codable {
    let name: String?
    let url: URL
    let question: String?
}


