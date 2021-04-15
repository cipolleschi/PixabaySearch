//
//  SearchResultsViewController.swift
//  PixabaySearch
//
//  Created by Andras Pal on 14/04/2021.
//

import UIKit

class SearchResultsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var searchString = String()
    private var imageArray = [ImageInfo]()
    private var tempLabel = UILabel()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .bgColour
        view.addSubview(tempLabel)
        tempLabel.text = searchString
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tempCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        tempCell.backgroundColor = UIColor.bgColour
        return tempCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupNavbar() {
        navigationItem.title = "Gallery"
        navigationController?.navigationBar.prefersLargeTitles = false
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
}
