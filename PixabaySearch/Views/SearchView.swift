//
//  SearchView.swift
//  PixabaySearch
//
//  Created by Andras Pal on 14/04/2021.
//

import UIKit

class SearchView: UIView {
    
    let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 24)
        title.textColor = .mainTextColour
        title.text = "Search for photos"
        title.numberOfLines = 0
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let textView: UITextField = {
        let textView = UITextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.placeholder = "Enter keywords to find images"
        
        textView.backgroundColor = UIColor.textFieldBG
        textView.layer.cornerRadius = 10
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textColor = UIColor.mainTextColour
        
        textView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        textView.layer.borderWidth = 1
        
        textView.textAlignment = NSTextAlignment.justified
        return textView
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Search Now", for: UIControl.State.normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    var searchTappedHandler: ((SearchView)->Void)?
    
    private func setupView() {
        
        backgroundColor = .bgColour
        
        addSubview(title)
        addSubview(textView)
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            title.rightAnchor.constraint(equalTo: self.rightAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor),
        ])
        
        NSLayoutConstraint.activate([
            
            textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            
            searchButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            searchButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        print("SearchView button tapped")
        self.searchTappedHandler?(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
