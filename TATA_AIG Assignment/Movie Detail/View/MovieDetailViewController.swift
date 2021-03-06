//
//  DetailViewController.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.requestDetails()
    }
    
    func loadMovieDetails(movie: MovieData) {
        lblTitle.text = movie.originalTitle
        lblRating.text = "Ratings: \(movie.userRating ?? 0)"
        lblOverview.text = movie.overview
        imageMovie.load(path: movie.imagePath ?? "", placeholder: nil)
    }
}
