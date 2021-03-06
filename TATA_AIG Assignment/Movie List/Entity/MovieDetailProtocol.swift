//
//  MovieDetailProtocol.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import Foundation

protocol MovieDetailViewProtocol {
    //Presenter -> View
    var presenter: MovieDetailPresenterProtocol? {get set}
    func loadMovieDetails()
}

protocol MovieDetailPresenterProtocol {
    //View -> Presenter
    var view: MovieDetailViewProtocol? {get set}
    var MovieDetail: MovieModel? {get set}

    func fetchFavourite() -> Bool
    func requestToToggleFavourite() -> Bool
    func updateFavourite()
    func getUserValue(index: IndexPath) -> String
}
