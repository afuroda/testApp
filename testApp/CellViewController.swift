//
//  CellViewController.swift
//  testApp
//
//  Created by 山口航輝 on 14/04/20.
//  Copyright © 2020 koki.yamaguchi. All rights reserved.
//

import UIKit


class CellViewController: UIViewController {
    
    var count = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBackLabel()
        makeNameLabel()
        makeAddressLabel()
        makeImage()
        makeNumLabel()
        makeTimeLabel()
        makePrLabel()

        // Do any additional setup after loading the view.
    }
    
    
    //背景色変更
    func makeBackLabel(){
        let backLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        backLabel.backgroundColor = .orange
        backLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height / 2)
        self.view.addSubview(backLabel)
    }
    
    //名称Label
    func makeNameLabel(){
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/10))
        nameLabel.text = ViewController.storeInfoName[TableViewController.cellNum] as? String
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height / 40)
        nameLabel.textAlignment = .center
        self.view.addSubview(nameLabel)
        
        
        
    }
    
    //prlabel
    func makePrLabel(){
        let prLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 1.29, height: self.view.bounds.height/7.5))
        prLabel.numberOfLines = 0
        prLabel.lineBreakMode = .byWordWrapping
        prLabel.text = ViewController.storePr[TableViewController.cellNum] as? String
        if ViewController.storePr[TableViewController.cellNum] as? String == ""{
            prLabel.text = "記載なし"
        }
        prLabel.layer.position = CGPoint(x: self.view.bounds.width/1.67, y: self.view.bounds.height / 1.67)
            
            prLabel.layer.borderWidth = 2
            prLabel.layer.borderColor = UIColor.yellow.cgColor
            prLabel.adjustsFontSizeToFitWidth = true
            prLabel.textAlignment = .center
            self.view.addSubview(prLabel)
            
        let prLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 5, height: self.view.bounds.height/7.5))
            prLabel2.text = "PR文"
            prLabel2.textAlignment = .center
            prLabel2.backgroundColor = .lightGray
            prLabel2.layer.borderWidth = 2
            prLabel2.layer.borderColor = UIColor.yellow.cgColor
            prLabel2.layer.position = CGPoint(x: self.view.bounds.width/9, y: self.view.bounds.height / 1.67)
            self.view.addSubview(prLabel2)
    }
    
    //住所Label
    func makeAddressLabel(){
        let addressLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 1.29, height: self.view.bounds.height/15))
        addressLabel.text = ViewController.storeAdress[TableViewController.cellNum] as? String
        addressLabel.layer.position = CGPoint(x: self.view.bounds.width/1.67, y: self.view.bounds.height / 2.3)
        
        addressLabel.layer.borderWidth = 2
        addressLabel.layer.borderColor = UIColor.yellow.cgColor
        addressLabel.adjustsFontSizeToFitWidth = true
        addressLabel.textAlignment = .center
        self.view.addSubview(addressLabel)
        
        let addressLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 5, height: self.view.bounds.height/15))
        addressLabel2.text = "住所"
        addressLabel2.textAlignment = .center
        addressLabel2.backgroundColor = .lightGray
        addressLabel2.layer.borderWidth = 2
        addressLabel2.layer.borderColor = UIColor.yellow.cgColor
        addressLabel2.layer.position = CGPoint(x: self.view.bounds.width/9, y: self.view.bounds.height / 2.3)
        self.view.addSubview(addressLabel2)
    }
    
    //電話番号Label
    func makeNumLabel(){
        let numLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 1.29, height: self.view.bounds.height/15))
        numLabel.text = ViewController.storeNum[TableViewController.cellNum] as? String
        numLabel.layer.position = CGPoint(x: self.view.bounds.width/1.67, y: self.view.bounds.height / 2)
        numLabel.layer.borderWidth = 2
        numLabel.layer.borderColor = UIColor.yellow.cgColor
        numLabel.adjustsFontSizeToFitWidth = true
        numLabel.textAlignment = .center
        self.view.addSubview(numLabel)
        
        let numLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 5, height: self.view.bounds.height/15))
        numLabel2.text = "電話番号"
        numLabel2.textAlignment = .center
        numLabel2.backgroundColor = .lightGray
        numLabel2.layer.borderWidth = 2
        numLabel2.layer.borderColor = UIColor.yellow.cgColor
        numLabel2.layer.position = CGPoint(x: self.view.bounds.width/9, y: self.view.bounds.height / 2)
        self.view.addSubview(numLabel2)
    }
    
    //営業時間label
    func makeTimeLabel(){
        
        //改行の有無とその数を調べる
        count = 1
        let str = "\(ViewController.storeTime[TableViewController.cellNum] as? String)"
        var nextRange = str.startIndex..<str.endIndex
        while let range = str.range(of: #"\"#, options: .caseInsensitive, range: nextRange) {
            count += 1
            nextRange = range.upperBound..<str.endIndex
        }
        
        let timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 1.29, height: self.view.bounds.height/15 * CGFloat(count)))
        
        //改行回数
        timeLabel.numberOfLines = count
        timeLabel.text = ViewController.storeTime[TableViewController.cellNum] as? String
        if ViewController.storeTime[TableViewController.cellNum] as? String == ""{
            timeLabel.text = "記載なし"
        }
        let bar = self.view.bounds.height / 15
        
        
        if count == 1{
            //改行なしの場合のLabelの位置
            timeLabel.layer.position = CGPoint(x: self.view.bounds.width/1.67, y: self.view.bounds.height / 1.43)
        }else{
            //改行ありの場合のLabelの位置
            timeLabel.layer.position = CGPoint(x: self.view.bounds.width/1.67, y: self.view.bounds.height / 1.43 + bar * CGFloat((count-1))/2)
        }
        
        timeLabel.layer.borderWidth = 2
        timeLabel.layer.borderColor = UIColor.yellow.cgColor
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.textAlignment = .center
        self.view.addSubview(timeLabel)
        
        let timeLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 5, height: self.view.bounds.height/15 * CGFloat(count)))
        
        timeLabel2.text = "営業時間"
        
        if count == 1{
            //改行なしの場合のLabel2の位置
            timeLabel2.layer.position = CGPoint(x: self.view.bounds.width/9, y: self.view.bounds.height / 1.43)
        }else{
            //改行ありの場合のLabel2の位置
            timeLabel2.layer.position = CGPoint(x: self.view.bounds.width/9, y: self.view.bounds.height / 1.43 + bar * CGFloat((count-1))/2)
        }
        
        timeLabel2.layer.borderWidth = 2
        timeLabel2.layer.borderColor = UIColor.yellow.cgColor
        timeLabel2.adjustsFontSizeToFitWidth = true
        timeLabel2.textAlignment = .center
        timeLabel2.backgroundColor = .lightGray
        self.view.addSubview(timeLabel2)
        
    }
    
    //店舗画像Image
    func makeImage(){
        let storeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/3))
        
        storeImageView.contentMode = .scaleAspectFit
        
       
        storeImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/4.5)
        
        if (ViewController.storeInfoPic[TableViewController.cellNum] as! String).isEmpty == false{
            let storeImageUrl = URL(string: ViewController.storeInfoPic[TableViewController.cellNum] as! String)
            var data = Data()
            
            do{
                data = try Data(contentsOf: storeImageUrl!)
            }catch{
                print("error")
            }
            let storeImage = UIImage(data: data)
            
            storeImageView.image = storeImage
        }else{
            storeImageView.image = UIImage(named: "noImage.jpg")
        }
        
        
        self.view.addSubview(storeImageView)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
