//
//  TATA_AIG_AssignmentTests.swift
//  TATA_AIG AssignmentTests
//
//  Created by Yashashree on 06/03/21.
//

import XCTest
@testable import TATA_AIG_Assignment

class MovieList: XCTestCase {
    var vc: MovieListViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = UIApplication.shared.getStoryboard().instantiateViewController(identifier: VIEWCONTROLLER.movieList.rawValue)
       _ = vc.view
    }

    func testIsCollectionViewLoaded(){
        XCTAssertNotNil(vc.collectionView)
    }

    func testCollectionViewSetDatasource(){
        XCTAssertTrue(vc.collectionView.dataSource is MovieListViewController)
    }
    
    func testCollectionViewSetDelegate(){
        XCTAssertTrue(vc.collectionView.delegate is MovieListViewController)
    }
    
    func testFetchPopularMoviesAPI(){
        let expectataion = self.expectation(description: "Popular Movies API")
        WebService.fetchDetails(url: .movies(type: .popularMovie, param: "&page=1")) { (result) in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
                do{
                    let details = try JSONDecoder().decode(MovieModel.self, from: data)
                    XCTAssertNotNil(details)
                    expectataion.fulfill()
                }catch{
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testFetchRatingMoviesAPI(){
        let expectataion = self.expectation(description: "Rating Movies API")
        WebService.fetchDetails(url: .movies(type: .topRatedMovie, param: "&page=1")) { (result) in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
                do{
                    let details = try JSONDecoder().decode(MovieModel.self, from: data)
                    XCTAssertNotNil(details)
                    expectataion.fulfill()
                }catch{
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testDataModel(){
        let json = """
        {
            "page": 2,
            "results": [
                {
                    "adult": false,
                    "backdrop_path": "/6aNKD81RHR1DqUUa8kOZ1TBY1Lp.jpg",
                    "genre_ids": [
                        35,
                        18
                    ],
                    "id": 637,
                    "original_language": "it",
                    "original_title": "La vita è bella",
                    "overview": "A touching story of an Italian book seller of Jewish ancestry.",
                    "popularity": 32.936,
                    "poster_path": "/74hLDKjD5aGYOotO6esUVaeISa2.jpg",
                    "release_date": "1997-12-20",
                    "title": "Life Is Beautiful",
                    "video": false,
                    "vote_average": 8.5,
                    "vote_count": 9930
                }
            ],
            "total_pages": 424,
            "total_results": 8474
        }
        """.data(using: String.Encoding.utf8)
        let movie = try? JSONDecoder().decode(MovieModel.self, from: json!)
        XCTAssertNotNil(movie) // movie is not Nil
        XCTAssertEqual(movie?.totalCount, 8474)
        XCTAssertEqual(movie?.totalPages, 424)
        XCTAssertNotNil(movie?.data) //movie contains result
        
        let value = movie?.data?[0]
        XCTAssertEqual(value?.originalTitle, "La vita è bella")
        XCTAssertEqual(value?.userRating, 8.5)
        XCTAssertEqual(value?.imagePath, "/74hLDKjD5aGYOotO6esUVaeISa2.jpg")
        XCTAssertEqual(value?.popularity,32.936)
        XCTAssertEqual(value?.overview,  "A touching story of an Italian book seller of Jewish ancestry.")
    }
}
