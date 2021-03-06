//
//  MovieListRouter.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import Foundation

class MovieListRouter: MovieListRouterProtocol{
    
    class func createMovieListModule(view: MovieListViewController){
        let presenter: MovieListPresenterProtocol & MovieListOutputInteractorProtocol = MovieListPresenter()
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.interactor = MovieListInteractor()
        view.presenter?.interactor?.presenter = presenter
        view.presenter?.router = MovieListRouter()
    }
    
    func navigateToMovieDetails(data: MovieData) {
        
    }
}
