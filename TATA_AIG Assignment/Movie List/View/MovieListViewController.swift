//
//  ViewController.swift
//  TATA_AIG Assignment
//
//  Created by Yashashree on 06/03/21.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var refresh: UIRefreshControl?
    var presenter: MovieListPresenterProtocol?
    var isPageRefreshing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieListRouter.createMovieListModule(view: self)
        
        refresh = UIRefreshControl()
        refresh?.addTarget(self, action: #selector(loadDetails(sender:)), for: .valueChanged)
        refresh?.tintColor = .white
        
        collectionView.refreshControl = refresh
        
        loadDetails(sender: nil)
    }
    
    //MARK:- IBACTION METHOD
    @IBAction func btnSort(sender: UIButton){
        let arrActions = ["Popularity", "Higest Rated"]
        showAlert(title: "Sort", message: "Sort Movie Details", actionTitles: arrActions, style: .actionSheet) {[weak self] (index) in
            self?.presenter?.sortMovies(text: arrActions[index])
        }
    }
    
    //MARK:- HELPER METHOD
    @objc func loadDetails(sender: UIRefreshControl?){
        ///Trigger to fetch movie details
        if sender != nil{
            sender?.endRefreshing()
        }
        presenter?.requestMovie(sender != nil)
    }
}

//MARK:- MOVIE LIST PROTOCOL
extension MovieListViewController: MovieListViewProtocol{
    func loadMovie() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.isPageRefreshing = false
        }
    }
    
    func showError(message: String) {
        self.showAlert(title: "Error", message: message, actionTitles: ["OK"], style: .alert) { (index) in
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
        if let details = presenter?.movieData(), let imagePath = details[indexPath.row].imagePath{
            cell.movieImageView.load(path: imagePath, placeholder: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        return CGSize(width: (width/2) - 10, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.requestMovieDetail(index: indexPath.row)
    }
}

//MARK:- UISCROLLVIEW METHODS
extension MovieListViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                presenter?.requestMovie(false)
            }
        }
    }
}

//MARK:- UITEXTFIELD METHODS
extension MovieListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let searchText = text.replacingCharacters(in: range, with: string)
            presenter?.requestSearch(text: searchText)
        }
        return true
    }
}

//MARK: List CollectionView Cell
class ListCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
}
