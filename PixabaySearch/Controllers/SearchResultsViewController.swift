//
//  SearchResultsViewController.swift
//  PixabaySearch
//
//  Created by Andras Pal on 14/04/2021.
//

import UIKit

class SearchResultsViewController: UIViewController, UICollectionViewDelegate {
    
    var searchString = String()
    private var imageArray = [ImageInfo]()
    private var tempImage = UIImageView()
    private var numberOfItems = 0
    private let myCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
        viewLayout.itemSize = CGSize(width: LayoutConstant.itemWidth, height: LayoutConstant.itemHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .bgColour
        return collectionView
    }()
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 10
        static let itemHeight: CGFloat = 150
        static let itemWidth: CGFloat = 150
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findImages(query: searchString)
        setupNavbar()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        view.backgroundColor = .bgColour
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.identifier)
        self.view.addSubview(myCollectionView)
    }
    
    private func setupLayouts() {
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            myCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setupNavbar() {
        navigationItem.title = "Gallery"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func getImageURL(row: Int) -> URL? {
        self.imageArray[row].previewURL
    }
    
    private func findImages(query: String) {
        NetworkService.shared.fetchImages(query: query, amount: 20) { (result) in
            switch result {
            case let .failure(error):
                let alerController = UIAlertController(title: "Error", message: "Detailed error messages are not implemented", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in }
                alerController.addAction(okAction)
                self.present(alerController, animated: true, completion: nil)
                print (error)
            case let .success(imageData):
                self.imageArray = imageData
                self.numberOfItems = self.imageArray.count
                self.myCollectionView.reloadData()
            }
        }
    }
}

extension SearchResultsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tempCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier, for: indexPath) as! ImageCollectionCell
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: tempCell.frame.size.width, height: tempCell.frame.size.height))
        tempCell.addSubview(imageView)
        tempCell.backgroundColor = UIColor.bgColour
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        if let url = getImageURL(row: indexPath.row) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        return tempCell
    }
}
