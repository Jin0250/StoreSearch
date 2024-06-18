//
//  AddressTableViewCell.swift
//  StoreSearch
//
//  Created by cmStudent on 2024/6/16.
//

import UIKit
import AlamofireImage

class AddressTableViewCell: UITableViewCell {

    
    private lazy var iconImg : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .red
        self.contentView.addSubview(imageV)
        imageV.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.height.equalTo(80)
        }
        
        return imageV
    }()
    private lazy var titleLabel : UILabel = {
        let label = creatLabel("",fontSizeM(14), .black)
        label.textAlignment = .left
        label.numberOfLines = 2
        self.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(iconImg.snp.right).offset(10)
            make.right.equalTo(-15)
            make.top.equalTo(iconImg.snp.top)
        }
        
        return label
    }()
    
    private lazy var addressLabel : UILabel = {
        let label = creatLabel("",fontSizeR(10), .black)
        label.textAlignment = .left
        label.numberOfLines = 2
        self.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(iconImg.snp.right).offset(10)
            make.right.equalTo(-15)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func iniCell(_ title : String,_ address : String,_ url : String)
    {
        self.titleLabel.text = title
        self.addressLabel.text = address
        self.iconImg.af.setImage(withURL: NSURL(string: url)! as URL)
    }

}
