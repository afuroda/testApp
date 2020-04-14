//
//  CustomCell.swift
//  testApp
//
//  Created by 山口航輝 on 14/04/20.
//  Copyright © 2020 koki.yamaguchi. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var NameLabel:UILabel!
    var ImageLabel:UIImageView!
    var AccessLabel1:UILabel!
    var AccessLabel2:UILabel!
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

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
        //labelを作成してcontentViewにadd
        self.NameLabel = UILabel()
        self.NameLabel.frame = CGRect(
            x: self.contentView.frame.width * 0.3,
          y: 0,
          width: self.contentView.frame.width * 0.8,
          height: self.contentView.frame.height
        )
        self.contentView.addSubview(self.NameLabel)
        
        self.ImageLabel = UIImageView()
        self.ImageLabel.frame = CGRect(
            x: 0,
          y: self.contentView.frame.width * 0.02,
          width: self.contentView.frame.width * 0.2,
          height: self.contentView.frame.width * 0.2
        )
        self.contentView.addSubview(ImageLabel)
        
        self.AccessLabel1 = UILabel()
        self.AccessLabel1.frame = CGRect(
            x: self.contentView.frame.width * 0.17,
          y: self.contentView.frame.width * 0.15,
          width: self.contentView.frame.width * 0.3,
          height: self.contentView.frame.height * 0.5
        )
        AccessLabel1.textAlignment = .center
        AccessLabel1.text = "アクセス"
        self.contentView.addSubview(AccessLabel1)
        
        self.AccessLabel2 = UILabel()
        self.AccessLabel2.frame = CGRect(
            x: self.contentView.frame.width * 0.45,
          y: self.contentView.frame.width * 0.15,
          width: self.contentView.frame.width * 0.7,
          height: self.contentView.frame.height * 0.5
        )
        AccessLabel2.textAlignment = .center
        AccessLabel2.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(AccessLabel2)
        
    }

}
