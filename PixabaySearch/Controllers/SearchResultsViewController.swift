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
    private var imageArray: Array<ImageInfo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findImages(query: searchString)
        setupNavbar()
        setupViews()
        setupLayouts()
        reloadTableView()
    }
    
    private func setupViews() {
        view.backgroundColor = .bgColour
        imagesTableView.dataSource = self
        imagesTableView.delegate = self
        view.addSubview(imagesTableView)
        imagesTableView.register(ImageCell.self, forCellReuseIdentifier: "searchCell")
        imagesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func setupLayouts() {
        imagesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imagesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            imagesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setupNavbar() {
        navigationItem.title = "Gallery"
    }
    
    private func getImageURL(row: Int) -> URL? {
        if let array = imageArray {
//            return array[row].previewURL
            return array[row].webformatURL
        }
        // TODO: fix the missing image url
        return URL(fileURLWithPath: "missingImageURL")
    }
    
    private func findImages(query: String) {
        NetworkService.shared.fetchImages(query: query, amount: 30) { (result) in
            switch result {
            case let .failure(error):
                let alerController = UIAlertController(title: "Error", message: "Detailed error messages are not implemented", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in }
                alerController.addAction(okAction)
                self.present(alerController, animated: true, completion: nil)
                print (error)
            case let .success(imageData):
                self.imageArray = imageData
            }
        }
    }
    
    fileprivate func reloadTableView() {
        NetworkService.shared.dispatchGroup.notify(queue: .main) {
            self.imagesTableView.reloadData()
        }
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! ImageCell
        cell.backgroundColor = UIColor.bgColour
        
        if let url = getImageURL(row: indexPath.row) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    cell.searchImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kUI.ImageSize.regular + kUI.Padding.defaultPadding
    }
}
