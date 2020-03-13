//
//  PPHomeTableViewCell.swift
//  BigThings
//
//  Created by PP on 2019/11/8.
//  Copyright © 2019 PP. All rights reserved.
//

import UIKit
import Kingfisher

class PPHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var locationL: UILabel!
    
    @IBOutlet weak var ratingL: UILabel!
    
    @IBOutlet weak var statusL: UILabel!
    
    public var thingsVo: PPThingsVo? {
        didSet {
            nameL.text = thingsVo?.name
            locationL.text = thingsVo?.location
            ratingL.text = thingsVo?.rating
            statusL.text = thingsVo?.status
            
            if thingsVo?.status == Optional("Inactive") {
                statusL.textColor = UIColor.red
            } else {
                statusL.textColor = UIColor(hex: 0x444444)
            }
            
            if let urlString = thingsVo?.image, urlString.count != 0 {
                self.imageV.kf.setImage(with: URL(string: imageUrlString + urlString), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            } else {
                self.imageV.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageV.contentMode = UIView.ContentMode.scaleAspectFill
        nameL.textColor = UIColor(hex: 0x333333)
        locationL.textColor = UIColor(hex: 0x666666)
        ratingL.textColor = UIColor(hex: 0x999999)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
