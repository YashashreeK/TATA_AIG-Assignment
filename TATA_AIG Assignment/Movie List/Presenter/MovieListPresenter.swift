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
    var arrMovies: [MovieData]?
    var isRefresh: Bool?
    fileprivate var selectedSort = MOVIE_TYPE.popularMovie{
        didSet{
            arrData = nil
            requestMovie(false)
        }
    }
    
    func requestMovie(_ isRefresh: Bool) {
        self.isRefresh = isRefresh
        let count = isRefresh ? 1 : (arrData?.page ?? 0) + 1
        if let totalCount = arrData?.totalCount{
            if  totalCount >= count{
                interactor?.fetchMovie(page: count, type: selectedSort)
            }
        }else{
            interactor?.fetchMovie(page: count, type: selectedSort)
        }
    }
    
    func requestMovieDetail(index: Int) {
        if let values = arrMovies{
            router?.navigateToMovieDetails(data: values[index])
        }
    }
    
    func sortMovies(text: String){
        let newSort = MOVIE_TYPE(rawValue: text) ?? .popularMovie
        if newSort != selectedSort{
            selectedSort = newSort
        }
    }
    
    func movieData() -> [MovieData] {
        return arrMovies ?? []
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
        arrMovies = arrData?.data
        view?.loadMovie()
    }
    
    func didFailWithError(error: String) {
        view?.showError(message: error)
    }
}
