//
//  ImageCollectionCell.swift
//  PixabaySearch
//
//  Created by Andras Pal on 16/04/2021.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

final class ImageCollectionCell: UICollectionViewCell {
        
    private let bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .bgColour
        bgView.layer.cornerRadius = 10
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    
    let searchImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private func setupView() {
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .clear
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
            searchImage.widthAnchor.constraint(equalToConstant: 120),
            searchImage.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageCollectionCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
