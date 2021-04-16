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
    private var tempImage = UIImageView()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .bgColour
        view.addSubview(tempImage)

        tempImage.translatesAutoresizingMaskIntoConstraints = false
        tempImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        tempImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        tempImage.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -20) .isActive = true

        findImages(query: searchString)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                
                if let url = URL(string: "\(self.imageArray[0].previewURL)") {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        
                        DispatchQueue.main.async {
                            self.tempImage.image = UIImage(data: data)?.resizeImage(targetSize: CGSize(width: 200, height: 200))
                        }
                    }
                    
                    task.resume()
                }
                self.reloadInputViews()
            }
        }
    }
}

extension UIImage {
    
  func resizeImage(targetSize: CGSize) -> UIImage {
    let size = self.size
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    self.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
}
