//
//  MovieModel.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import Foundation

struct MovieModel: Codable{
    var page: Int?
    var data: [MovieData]?
    var totalPages: Int?
    var totalCount: Int?
    
    enum RootKey: String, CodingKey{
        case page
        case data = "results"
        case totalPages = "total_pages"
        case totalCount = "total_results"
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: RootKey.self)
        
        page = try values.decode(Int.self, forKey: .page)
        data = try values.decode([MovieData].self, forKey: .data)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        totalCount = try values.decode(Int.self, forKey: .totalCount)
    }
    
}

struct MovieData: Codable{
    var id: Int?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var imagePath: String?
    var userRating: Double?
    
    enum RootKey: String, CodingKey{
        case id
        case originalTitle = "original_title"
        case overview
        case popularity
        case imagePath = "poster_path"
        case userRating = "vote_average"
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: RootKey.self)
        
        id = try values.decode(Int.self, forKey: .id)
        originalTitle = try values.decode(String.self, forKey: .originalTitle)
        overview = try values.decode(String.self, forKey: .overview)
        imagePath = try values.decode(String.self, forKey: .imagePath)
        popularity = try values.decode(Double.self, forKey: .popularity)
        userRating = try values.decode(Double.self, forKey: .userRating)
    }
    
}
