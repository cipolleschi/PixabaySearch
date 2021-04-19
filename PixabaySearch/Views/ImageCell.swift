//
//  ImageCollectionCell.swift
//  PixabaySearch
//
//  Created by Andras Pal on 16/04/2021.
//

import UIKit

class ImageCell: UITableViewCell {
    
    private let bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .bgColour
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    
    let searchImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func setupView() {
        
        contentView.clipsToBounds = true
        contentView.backgroundColor = .bgColour
        contentView.addSubview(bgView)
        bgView.addSubview(searchImage)
    }
    
    private func setupLayouts() {

        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: kUI.Padding.defaultPadding),
            bgView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -kUI.Padding.defaultPadding),
            bgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: kUI.Padding.defaultPadding),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: kUI.Padding.defaultPadding)
        ])
        
        NSLayoutConstraint.activate([
            searchImage.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            searchImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: kUI.Padding.defaultPadding),
            searchImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -kUI.Padding.defaultPadding),
            searchImage.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
