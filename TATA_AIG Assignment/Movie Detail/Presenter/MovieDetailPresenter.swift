//
//  DetailPresenter.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 07/03/21.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol{
    var view: MovieDetailViewProtocol?
    var movie: MovieData?
    
    func requestDetails() {
        if let movie = movie{
            view?.loadMovieDetails(movie: movie)
        }
    }
}
