//
//  Enum.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 07/03/21.
//

import Foundation

fileprivate enum API_BASE: String {
    case key = "fbca4bb532880b835a26e7b109f071c7"
    case domain = "https://api.themoviedb.org/3"
    case imageDomain = "https://image.tmdb.org/t/p/w300/"
}

enum API_METHOD: String{
    case popularMovie = "/movie/popular"
    case topRatedMovie = "/movie/top_rated"
}

enum API_URL{
    case movies(type: API_METHOD, param: String)
    case image(path: String)
    
    func url() -> String{
        switch self {
        case .image(let path):
            return "\(API_BASE.imageDomain.rawValue)\(path)"
        case .movies(let type, let param):
            return "\(API_BASE.domain.rawValue)\(type.rawValue)?api_key=\(API_BASE.key.rawValue)\(param)"
        }
    }
}


enum NetworkError: Error {
    case badURL
    case noData
    case badStatusCode(code: Int)
    case conversionFailed
    case error(message: String)
}

extension NetworkError: LocalizedError{
    var errorDescription: String?{
        switch self {
        case .badURL:
            return "The requested url is not proper"
        case .badStatusCode(let code):
            return "Error: unexpected status code \(code)"
        case .noData:
            return "Error: No Data found for processing"
        case .conversionFailed:
            return "Error occurred while processing data"
        case .error(let message):
            return message
        }
    }
}


enum VIEWCONTROLLER: String{
    case movieList = "MovieListViewController"
    case movieDetail = "MovieDetailViewController"
}

enum MOVIE_TYPE: String{
    case popularMovie = "Popularity"
    case topRatedMovie = "Higest Rated"
}
