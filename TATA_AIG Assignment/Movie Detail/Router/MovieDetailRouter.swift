//
//  DetailRouter.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 07/03/21.
//

import Foundation

class MovieDetailRouter{
    
    class func createDetailModule(view: MovieDetailViewController, data: MovieData){
        let presenter: MovieDetailPresenterProtocol = MovieDetailPresenter()
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.movie = data
    }
}
