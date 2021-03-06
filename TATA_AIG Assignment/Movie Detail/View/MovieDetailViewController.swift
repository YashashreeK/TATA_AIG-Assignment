//
//  DetailViewController.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func loadMovieDetails(movie: MovieData) {
        
    }
}
