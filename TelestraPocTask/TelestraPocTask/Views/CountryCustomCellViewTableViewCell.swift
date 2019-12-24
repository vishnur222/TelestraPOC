//
//  TACountryCustomCellViewTableViewCell.swift
//  TelestraPocTask
//
//  Created by v.r.ramachandran on 23/12/19.
//  Copyright © 2019 v.r.ramachandran. All rights reserved.
//

import UIKit
import SDWebImage

class CountryCustomCellViewTableViewCell: UITableViewCell {
    private let minimumCellHeight: CGFloat = 150
    private let paddingLeadTop: CGFloat = 10
    private let paddingTrailBottom: CGFloat = -20
    private let imageSize = (width: CGFloat(200), height: CGFloat(150))
    var product : ModelTitleRow? {
        didSet {
            
            setImage(imageUrl: product?.imageHref, placeHolder: Constants.ConfigdefaultImgName.defaultImgName)
            productNameLabel.text = product?.title
            productDescriptionLabel.text = product?.description
        }
    }
    
    // MARK: Table cell Labels & UIImage creation
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setImage(imageUrl: String?, placeHolder: String) {
        productImage.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: UIImage(named: placeHolder))
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
        let imgView = UIImageView(image: #imageLiteral(resourceName: Constants.ConfigdefaultImgName.defaultImgName))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImage)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        setcellAutolayout()
    }
    
    func setcellAutolayout()  {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumCellHeight),
            
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: paddingLeadTop),
            productImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 200),
            productImage.heightAnchor.constraint(equalToConstant: 150),
            
            productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: paddingLeadTop),
            productNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  paddingTrailBottom),
            
            productDescriptionLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            productDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: paddingTrailBottom)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

}
