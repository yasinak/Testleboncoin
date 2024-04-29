//
//  AdTableviewCell.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//

import UIKit

class AdTableviewCell: UITableViewCell {
    
    static let identifier = "adTableview"
    
    //  update cell view when model get data
    var ad: Home.Ads.ViewModelAd? {
        didSet {
            titlelabel.text = ad?.title
            categorylabel.text = ad?.categoryName
            pricelabel.text = ad?.price
            if let imagesUrlSmall = ad?.imagesUrlSmall {
                adImageView.loadImage(fromURL: imagesUrlSmall)
            }
        }
    }
    
    //  Main StackView
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // StackView which labels
    private let innerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let adImageView: CachedImageView = {
        let imageView = CachedImageView()
        return imageView
    }()
    
    //  labels
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let categorylabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private let pricelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        NSLayoutConstraint.activate([
            adImageView.widthAnchor.constraint(equalToConstant: 100),
            adImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        // add labels to stackView
        innerStackView.addArrangedSubview(titlelabel)
        innerStackView.addArrangedSubview(categorylabel)
        innerStackView.addArrangedSubview(pricelabel)
        
        mainStackView.addArrangedSubview(adImageView)
        mainStackView.addArrangedSubview(innerStackView)
        
        // Add stackView to contentView
        contentView.addSubview(mainStackView)
        
        // Define contraints to stackView
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
