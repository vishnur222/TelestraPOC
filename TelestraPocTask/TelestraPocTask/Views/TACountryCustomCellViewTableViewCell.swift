//
//  TACountryCustomCellViewTableViewCell.swift
//  TelestraPocTask
//
//  Created by v.r.ramachandran on 23/12/19.
//  Copyright © 2019 v.r.ramachandran. All rights reserved.
//

import UIKit

class TACountryCustomCellViewTableViewCell: UITableViewCell {

    var product : Product? {
        didSet {
            
            setImage(imageUrl: product?.productImage, placeHolder: "default")
            productNameLabel.text = product?.productName
            productDescriptionLabel.text = product?.productDesc
        }
    }
    
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setImage(imageUrl: String?, placeHolder: String) {
        // set the image to UIImageView here
    }
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productImage : UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImage)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            productImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 100),
            productImage.heightAnchor.constraint(equalToConstant: 100),
            
            productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            productNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -16),
            
            productDescriptionLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            productDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

}
