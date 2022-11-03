//
//  LagosDevTableViewCell.swift
//  OzeAssesment
//
//  Created by Mac on 02/11/2022.
//

import UIKit

class LagosDevTableViewCell: UITableViewCell {
    
    lazy var devAvater: UIImageView = {
        let image = UIImageView()
        image.constrainSize(width: 40, height: 40)
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    lazy var devName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var favouriteAvater: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bookmark.fill")
        image.constrainSize(width: 40, height: 40)
        return image
    }()
   
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupLayout() {
        contentView.addSubview([devAvater, devName, favouriteAvater])
        devAvater.constrainLeft(to: contentView, constant: 10)
        devAvater.constrainCenterY(to: contentView)
        devName.constrainCenterY(to: contentView)
        devName.constrainLeftToRight(of: devAvater, constant: 10)
        favouriteAvater.constrainCenterY(to: contentView)
        favouriteAvater.constrainRight(to: contentView, constant: -10)
    }
    
    public func setUpData(data: TableViewValue?) {
        devAvater.loadImage(urlString: data?.avatarURL ?? "")
        devName.text = data?.login
        if data?.repoData.count ?? 0 > 0 {
            favouriteAvater.isHidden = false
        } else {
            favouriteAvater.isHidden = true
        }
    }
}
