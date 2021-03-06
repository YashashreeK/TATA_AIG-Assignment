//
//  MovieListProtocol.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import Foundation

protocol MovieListViewProtocol: class {
    //Presenter -> View
    var presenter: MovieListPresenterProtocol? {get set}
    
    func loadMovie()
}

protocol MovieListPresenterProtocol: class {
    //View -> Presenter
    var view: MovieListViewProtocol? {get set}
    var interactor: MovieListInteractorProtocol? {get set}
    var router: MovieListRouterProtocol? {get set}
    
    func requestAllMovie()
    func requestMovieDetail(index: Int)
    func movieData() -> [MovieData]
}

protocol MovieListInteractorProtocol: class {
    //Presenter -> Interactor
    var presenter: MovieListOutputInteractorProtocol? {get set}
    
    func fetchMovie(page:Int)
}

protocol MovieListOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func didReceiveMovie(data: MovieModel)
    func didFailWithError(error: String)
}

protocol MovieListRouterProtocol: class {
    //Presenter -> Router
    func navigateToMovieDetails(data: MovieData)
}


