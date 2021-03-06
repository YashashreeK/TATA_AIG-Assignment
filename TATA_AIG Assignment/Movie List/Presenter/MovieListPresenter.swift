//
//  MovieListPresenter.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import Foundation

class MovieListPresenter: MovieListPresenterProtocol{
    var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var router: MovieListRouterProtocol?
    var arrData: MovieModel?
    
    func requestAllMovie() {
        let count = (arrData?.page ?? 0) + 1
        interactor?.fetchMovie(page: count)
    }
    
    func requestMovieDetail(index: Int) {
        if let values = arrData?.data{
            router?.navigateToMovieDetails(data: values[index])
        }
    }
    
    func movieData() -> [MovieData] {
        return arrData?.data ?? []
    }
}

extension MovieListPresenter: MovieListOutputInteractorProtocol{
    func didReceiveMovie(data: MovieModel) {
        arrData = data
        view?.loadMovie()
    }
    
    func didFailWithError(error: String) {
        
    }
}
