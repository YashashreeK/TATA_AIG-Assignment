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
    var isRefresh: Bool?
    
    func requestMovie(_ isRefresh: Bool) {
        self.isRefresh = isRefresh
        let count = isRefresh ? 1 : (arrData?.page ?? 0) + 1
        if let totalCount = arrData?.totalCount{
            if  totalCount >= count{
                interactor?.fetchMovie(page: count)
            }
        }else{
            interactor?.fetchMovie(page: count)
        }
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
        if let values = arrData, isRefresh == false{
            ///pagination
            var arrMovies = values.data
            arrMovies?.append(contentsOf: data.data ?? [])
            
            arrData = data
            arrData?.data = arrMovies
        }else{
            arrData = data
        }
        view?.loadMovie()
    }
    
    func didFailWithError(error: String) {
        
    }
}
