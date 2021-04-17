//
//  ImageCollectionCell.swift
//  PixabaySearch
//
//  Created by Andras Pal on 16/04/2021.
//

import UIKit

final class ImageCell: UITableViewCell {
        
    private let bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .bgColour
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    
    let searchImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
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
            bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            bgView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            bgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchImage.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            searchImage.widthAnchor.constraint(equalToConstant: 200),
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
