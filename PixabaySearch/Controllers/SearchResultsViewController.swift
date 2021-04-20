//
//  SearchResultsViewController.swift
//  PixabaySearch
//
//  Created by Andras Pal on 14/04/2021.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate {
    
    var searchString = String()
    private let imagesTableView = UITableView()
    private var imageInfoArray: Array<ImageInfo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findImageInfo(query: searchString)
        setupNavbar()
        setupViews()
        setupLayouts()
        reloadTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        CacheManager.shared.searchCache.removeAll()
        CacheManager.shared.imageCache.removeAll()
    }
    
    private func setupViews() {
        view.backgroundColor = .bgColour
        imagesTableView.dataSource = self
        imagesTableView.delegate = self
        view.addSubview(imagesTableView)
        imagesTableView.register(ImageCell.self, forCellReuseIdentifier: "searchCell")
        imagesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        imagesTableView.bounces = false
    }
    
    private func setupLayouts() {
        imagesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -kUI.Padding.defaultPadding),
            imagesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            imagesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setupNavbar() {
        navigationItem.title = "Gallery"
    }
    
    private func getImageURL(row: Int) -> URL? {
        if let array = imageInfoArray {
            return array[row].largeImageURL
        }
        // TODO: fix the missing image url
        return URL(fileURLWithPath: "missingImageURL")
    }
    
    private func getImageId(row: Int) -> Int {
        if let array = imageInfoArray {
            return array[row].id
        }
        // TODO: can this even happen? basically it means there is an error
        return 1
    }
    
    private func findImageInfo(query: String) {
        if CacheManager.shared.isImageInfoSaved(query: searchString) == true {
            imageInfoArray = CacheManager.shared.returnImageInfo(query: searchString)
        } else {
            NetworkService.shared.fetchImageData(query: query, amount: 25) { (result) in
                switch result {
                case let .failure(error):
                    self.presentAlert(title: "Error", message: "Detailed error messages are not implemented")
                    print (error)
                case let .success(imageData):
                    self.imageInfoArray = imageData
                    CacheManager.shared.updateSearchCache(searchString: self.searchString, searchResults: imageData)
                    
                    if self.imageInfoArray?.count == 0 {
                        self.presentAlert(title: "No results", message: "Try to use different keywords")
                    }
                }
            }
        }
    }
    
    private func reloadTableView() {
        NetworkService.shared.dispatchGroup.notify(queue: .main) {
            self.imagesTableView.reloadData()
        }
    }
    
    private func calculateCellHeight(indexPathRow: Int) -> CGFloat {
        guard let images = imageInfoArray else { return kUI.ImageSize.regular + kUI.Padding.defaultPadding }
        let imageWidth = Double(images[indexPathRow].webformatWidth)
        let imageHeight = Double(images[indexPathRow].webformatHeight)
        let contentWidth = Double(UIScreen.main.bounds.width - (kUI.Padding.defaultPadding * 2))
        let cellHeight = (imageHeight / (imageWidth / contentWidth))
        return CGFloat(cellHeight)
    }
    
    private func presentAlert(title: String, message: String) {
        let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in }
        alerController.addAction(okAction)
        self.present(alerController, animated: true, completion: nil)
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageInfoArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! ImageCell
        cell.backgroundColor = UIColor.bgColour
        cell.selectionStyle = .none
        
        if let url = getImageURL(row: indexPath.row) {
            
            if CacheManager.shared.isImageSaved(imageId: self.getImageId(row: indexPath.row)) == true {
                cell.searchImage.image = CacheManager.shared.returnImage(imageId: self.getImageId(row: indexPath.row))
            } else {
                
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async {
                        cell.searchImage.image = UIImage(data: data)
                        CacheManager.shared.updateImageCache(imageId: self.getImageId(row: indexPath.row), image: cell.searchImage.image!)
                        //                        print("imageCache content: \(CacheManager.shared.imageCache)")
                    }
                }
                task.resume()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateCellHeight(indexPathRow: indexPath.row)
    }
}
