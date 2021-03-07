//
//  MovieDetail.swift
//  TATA_AIG AssignmentTests
//
//  Created by Yashashree on 07/03/21.
//

import XCTest
@testable import TATA_AIG_Assignment

class MovieDetail: XCTestCase {
    var vc: MovieDetailViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = UIApplication.shared.getStoryboard().instantiateViewController(identifier: VIEWCONTROLLER.movieDetail.rawValue)
       _ = vc.view
        
        var model = MovieData()
        model.originalTitle = "La vita è bella"
        model.userRating = 8.5
        model.imagePath = "/74hLDKjD5aGYOotO6esUVaeISa2.jpg"
        model.popularity = 32.936
        model.overview = "A touching story of an Italian book seller of Jewish ancestry."
        MovieDetailRouter.createDetailModule(view: vc, data: model)
    }
    
    func testMovieNotDetail(){
        XCTAssertNotNil(vc.presenter?.movie)
    }
    
    func testMovieDetail(){
        XCTAssertEqual(vc.presenter?.movie?.originalTitle, "La vita è bella")
        XCTAssertEqual(vc.presenter?.movie?.userRating, 8.5)
        XCTAssertEqual(vc.presenter?.movie?.imagePath, "/74hLDKjD5aGYOotO6esUVaeISa2.jpg")
        XCTAssertEqual(vc.presenter?.movie?.popularity,32.936)
        XCTAssertEqual(vc.presenter?.movie?.overview,  "A touching story of an Italian book seller of Jewish ancestry.")
    }
}
