//
//  TableViewController.swift
//  testApp
//
//  Created by 山口航輝 on 14/04/20.
//  Copyright © 2020 koki.yamaguchi. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    var tableView = UITableView()
    
    //cellの番号格納用変数
    static var cellNum = 0
    
    //cellの高さ変更
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.bounds.height / 8
    }
    
    //cellの個数取得
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ViewController.storeHit < 10{
            return ViewController.storeHit
        }else{
            return 10
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルのインスタンスの作成
        let cell = tableView.dequeueReusableCell(
          withIdentifier: "CustomCell",
          for: indexPath as IndexPath
        ) as! CustomCell
        // cellオブジェクトのLabelに値をセット。
        cell.NameLabel.textAlignment = .center
        cell.NameLabel.adjustsFontSizeToFitWidth = true
        cell.NameLabel.text = ViewController.storeInfoName[indexPath.row] as? String
        
        //画像URLの有無を確かめる
                if (ViewController.storeInfoPic[indexPath.row] as! String).isEmpty == false{
                    let storeImageUrl = URL(string: ViewController.storeInfoPic[indexPath.row] as! String)
                    var data = Data()
        
                    do{
                        data = try Data(contentsOf: storeImageUrl!)
                    }catch{
                        print("error")
                    }
                    let storeImage = UIImage(data: data)
        
                    cell.ImageLabel.image = storeImage
                }else{
                    //画像がない場合NoImageを表示させる
                    cell.ImageLabel.image = UIImage(named: "noImage.jpg")
                }
        
       
        cell.AccessLabel2.text = "最寄駅 \(ViewController.storeStation[indexPath.row] as! String) \(ViewController.storeStationExit[indexPath.row] as! String)から徒歩\(ViewController.storeWalk[indexPath.row] as! String)分"
        
        
        //アクセスlabelの記述処理
        if Int(ViewController.storeWalk[indexPath.row] as! String) == nil{
        cell.AccessLabel2.text = "最寄駅 \(ViewController.storeStation[indexPath.row] as! String) \(ViewController.storeStationExit[indexPath.row] as! String)から\(ViewController.storeWalk[indexPath.row] as! String)分"
            
        }
        
        if ((ViewController.storeStation[indexPath.row] as AnyObject) as! String) == "" && ((ViewController.storeStationExit[indexPath.row] as AnyObject) as! String) == "" && ((ViewController.storeWalk[indexPath.row] as AnyObject) as! String) == ""{
            cell.AccessLabel2.text = "記載なし"
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TableViewController.cellNum = indexPath.row
        // 画面遷移を行う
        performSegue(withIdentifier: "Segue", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.tableView.register(
          CustomCell.self,
          forCellReuseIdentifier: "CustomCell"
        )
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(tableView)

        // Do any additional setup after loading the view.
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
