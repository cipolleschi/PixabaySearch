//
//  SearchView.swift
//  PixabaySearch
//
//  Created by Andras Pal on 14/04/2021.
//

import UIKit

class SearchView: UIView {
    
    let bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .bgColour
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    
    let pixabayLogo: UIImageView = {
        let pixabayLogo = UIImageView(frame: .zero)
        pixabayLogo.image = UIImage(named: "pixabayLogo")
        pixabayLogo.translatesAutoresizingMaskIntoConstraints = false
        pixabayLogo.clipsToBounds = true
        pixabayLogo.contentMode = .scaleAspectFit
        return pixabayLogo
    }()
    
    let bgImage: UIImageView = {
        let bgImage = UIImageView(frame: .zero)
        bgImage.image = UIImage(named: "pixabayBackground")
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        bgImage.contentMode = .scaleAspectFill
        return bgImage
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: kUI.Size.regularFont)
        title.text = "Stunning free images"
        title.textColor = .mainTextColour
        title.numberOfLines = 0
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let textView: TextFieldWithPadding = {
        let textView = TextFieldWithPadding()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.textFieldBG
        textView.layer.cornerRadius = kUI.Size.cornerRadius
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textColor = UIColor.mainTextColour
        textView.attributedPlaceholder = NSAttributedString(string: "Search images",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFieldTextColour])
        textView.layer.borderColor = UIColor.textFieldTextColour.cgColor
        textView.layer.borderWidth = 1
        textView.textAlignment = NSTextAlignment.justified
        return textView
    }()
    
    let searchButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .buttonColour
        button.layer.cornerRadius = kUI.Size.cornerRadius
        button.setTitle("Search Now", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    var searchTappedHandler: ((SearchView)->Void)?
    
    private func setupView() {
        
        backgroundColor = .bgColour
        
        addSubview(bgView)
        bgView.insertSubview(bgImage, at: 0)
        addSubview(pixabayLogo)
        addSubview(title)
        addSubview(textView)
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: self.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: bgView.topAnchor),
            bgImage.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pixabayLogo.topAnchor.constraint(equalTo: bgView.topAnchor, constant: kUI.Padding.largePadding * 2),
            pixabayLogo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: kUI.Padding.defaultPadding),
            pixabayLogo.heightAnchor.constraint(equalToConstant: kUI.Size.pixaLogoHeight),
            pixabayLogo.widthAnchor.constraint(equalToConstant: calculateLogoWidth())
        ])
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: pixabayLogo.bottomAnchor, constant: kUI.Padding.largePadding),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: kUI.Padding.defaultPadding),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -kUI.Padding.defaultPadding),
        ])
        
        NSLayoutConstraint.activate([
            
            textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: kUI.Padding.defaultPadding),
            textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: kUI.Padding.defaultPadding),
            textView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -kUI.Padding.defaultPadding),
            textView.heightAnchor.constraint(equalToConstant: kUI.Size.textFieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            
            searchButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: kUI.Padding.defaultPadding),
            searchButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: kUI.Padding.defaultPadding),
            searchButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -kUI.Padding.defaultPadding),
            searchButton.heightAnchor.constraint(equalToConstant: kUI.Size.searchButtonHeight)
        ])
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        print("SearchView button tapped")
        self.searchTappedHandler?(self)
    }
    
    private func calculateLogoWidth() -> CGFloat {
        guard let imageSize = pixabayLogo.image?.size else {
            return 150
        }
        let newHeight = imageSize.width / (imageSize.height / 40)
        return newHeight
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
