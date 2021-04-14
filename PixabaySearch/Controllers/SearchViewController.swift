//
//  ViewController.swift
//  PixabaySearch
//
//  Created by Andras Pal on 13/04/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var imageArray = [ImageInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        loadImages(query: "food, corn")
    }
    
    private func loadImages (query: String) {
        
        NetworkService.shared.fetchImages(query: query, amount: 10) { (result) in
            switch result {
            case let .failure(error):
                let alerController = UIAlertController(title: "Error", message: "This is not that helpful, but something went wrong.", preferredStyle: .alert)
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
    
    private func setupNavbar() {
        
        navigationItem.title = "Pixabay Image Search"
    }
}
