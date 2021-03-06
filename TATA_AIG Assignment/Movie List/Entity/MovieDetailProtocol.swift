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
    
    func loadMovieDetails(movie: MovieData)
}

protocol MovieDetailPresenterProtocol {
    //View -> Presenter
    var view: MovieDetailViewProtocol? {get set}
    var movie: MovieData? {get set}
    
    func requestDetails()
}
