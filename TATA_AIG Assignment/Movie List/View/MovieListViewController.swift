//
//  ViewController.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var refresh: UIRefreshControl?
    var presenter: MovieListPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        MovieListRouter.createMovieListModule(view: self)
        
        refresh = UIRefreshControl()
        refresh?.addTarget(self, action: #selector(loadDetails(sender:)), for: .valueChanged)
        collectionView.refreshControl = refresh
        
        loadDetails(sender: nil)
    }
    
    //MARK:- HELPER METHOD
    @objc func loadDetails(sender: UIRefreshControl?){
        ///Trigger to fetch movie details
        if sender != nil{
            sender?.endRefreshing()
        }
        presenter?.requestAllMovie()
    }
}

//MARK:- MOVIE LIST PROTOCOL
extension MovieListViewController: MovieListViewProtocol{
    func loadMovie() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}


//MARK:- UICOLLECTIONVIEW METHODS
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movieData().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ListCell
        cell.backgroundColor = .systemIndigo
        
        if let details = presenter?.movieData(), let imagePath = details[indexPath.row].imagePath{
            cell.movieImageView.load(path: imagePath, placeholder: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        return CGSize(width: (width/2) - 10, height: 300)
    }    
}


//MARK: List CollectionView Cell
class ListCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
}
