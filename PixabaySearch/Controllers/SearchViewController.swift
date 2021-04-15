//
//  ViewController.swift
//  PixabaySearch
//
//  Created by Andras Pal on 13/04/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var imageArray = [ImageInfo]()
    private let searchView = SearchView()
    
    override func loadView() {
        view = searchView
        searchView.searchTappedHandler = handleButtonTap(_:)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavbar()
    }
    
    private func findImages(query: String) {
        
        NetworkService.shared.fetchImages(query: query, amount: 10) { (result) in
            switch result {
            case let .failure(error):
                let alerController = UIAlertController(title: "Error", message: "Detailed error messages are not implemented", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in }
                alerController.addAction(okAction)
                self.present(alerController, animated: true, completion: nil)
                print (error)
            case let .success(imageData):
                self.imageArray = imageData
                print("images: \(self.imageArray[0])")
            }
        }
    }
    
//    private func setupSearchController() {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.placeholder = "Enter keywords to find images"
//        searchController.searchBar.delegate = self
//        navigationItem.searchController = searchController
//    }
    
    private func setupNavbar() {
        navigationItem.title = "Pixabay images"
    }
    
    private func handleButtonTap(_ customView: SearchView) {
        print("tap")
    }
}

//extension SearchViewController: UISearchBarDelegate {
//
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        return true
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        guard let query = searchBar.text else {
//            return
//        }
//        findImages(query: query)
//    }
//}
