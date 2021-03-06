//
//  MovieListInteractor.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import Foundation

class MovieListInteractor: MovieListInteractorProtocol{
    var presenter: MovieListOutputInteractorProtocol?
    
    func fetchMovie(page: Int, type: MOVIE_TYPE) {
        let param = "&page=\(page)"
        let type: API_METHOD = type == .popularMovie ? .popularMovie : .topRatedMovie
        WebService.fetchDetails(url:.movies(type: type, param: param)) { (result) in
            switch result{
            case .success(let data):
                do{
                    let detail = try JSONDecoder().decode(MovieModel.self, from: data)
                    self.presenter?.didReceiveMovie(data: detail)
                } catch{
                    self.presenter?.didFailWithError(error: NetworkError.conversionFailed.localizedDescription)
                }
            case .failure(let error):
                self.presenter?.didFailWithError(error: error.localizedDescription)
            }
        }
    }

}
