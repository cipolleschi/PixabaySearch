//
//  ViewController.swift
//  PixabaySearch
//
//  Created by Andras Pal on 13/04/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    override func loadView() {
        view = searchView
        searchView.searchTappedHandler = handleButtonTap(_:)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavbar()
    }
    
    private func setupNavbar() {
        navigationItem.title = "Pixabay images"
    }
    
    private func updateNavbar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.tintColor = .mainTextColour
        navigationItem.backBarButtonItem = backButton
        navigationItem.title = ""
    }
    
    private func handleButtonTap(_ customView: SearchView) {
        guard let searchString = searchView.textView.text else {
            print("error with the searchString")
            return
        }
        if searchString != "" {
            let searchResultsVC = SearchResultsViewController()
            self.navigationController?.pushViewController(searchResultsVC, animated: true)
            searchResultsVC.searchString = searchString
            self.updateNavbar()
        }
    }
}
