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
            urgentlabel.isHidden = !(ad?.isUrgent ?? false)
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
    private let rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let leftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let adImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.backgroundColor = UIColor(named: "LBCGrey")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //  urgent
    private let urgentlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.text = " URGENT "
        label.textColor = UIColor(named: "LBCOrange")
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        label.layer.borderColor = UIColor(named: "LBCOrange")?.cgColor
        label.layer.borderWidth = 1
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //  title
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    //  category
    private let categorylabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    //  price
    private let pricelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    //  adjustment view
    //  I use this view to adjut the position of the others labels, it will push the other label to the extremity
    private let adjustmentView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        NSLayoutConstraint.activate([
            leftView.widthAnchor.constraint(equalToConstant: 100),
            leftView.heightAnchor.constraint(equalToConstant: 100)
        ])
        leftView.addSubview(adImageView)
        leftView.addSubview(urgentlabel)
        
        //  fix image size
        NSLayoutConstraint.activate([
            adImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 0),
            adImageView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 0),
            adImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 0),
            adImageView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: 0)
        ])
        
        
        //  urgent label
        NSLayoutConstraint.activate([
            urgentlabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 4),
            urgentlabel.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 4),
        ])

        
        // add labels to stackView
        rightStackView.addArrangedSubview(titlelabel)
        rightStackView.addArrangedSubview(categorylabel)
        rightStackView.addArrangedSubview(adjustmentView)
        rightStackView.addArrangedSubview(pricelabel)
        
        mainStackView.addArrangedSubview(leftView)
        mainStackView.addArrangedSubview(rightStackView)
        
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
