//
//  SearchResultsViewController.swift
//  PixabaySearch
//
//  Created by Andras Pal on 14/04/2021.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate {
    
    private let myTableView = UITableView()
    
    var searchString = String()
    private var imageArray = [ImageInfo]()
    private var numberOfItems = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findImages(query: searchString)
        setupNavbar()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        view.backgroundColor = .bgColour
        myTableView.dataSource = self
        myTableView.delegate = self
        view.addSubview(myTableView)
        myTableView.register(ImageCell.self, forCellReuseIdentifier: "searchCell")
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func setupLayouts() {
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            myTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
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
                self.myTableView.reloadData()
            }
        }
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! ImageCell
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
        cell.addSubview(imageView)
        cell.backgroundColor = UIColor.bgColour
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
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
