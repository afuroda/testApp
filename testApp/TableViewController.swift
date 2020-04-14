//
//  TableViewController.swift
//  testApp
//
//  Created by 山口航輝 on 14/04/20.
//  Copyright © 2020 koki.yamaguchi. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    //cellの番号格納用変数
    static var cellNum = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.storeInfoName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel!.text = ViewController.storeInfoName[indexPath.row] as? String
        
        let storeImageView = UIImageView(frame: CGRect(x: self.view.bounds.width/20, y: 0, width: self.view.bounds.width/10, height: self.view.bounds.height/15))
         
         storeImageView.contentMode = .scaleAspectFit
         
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
            
            storeImageView.image = storeImage
        }else{
            //画像がない場合NoImageを表示させる
            storeImageView.image = UIImage(named: "noImage.jpg")
        }
        
        cell.contentView.addSubview(storeImageView)
        cell.tag = indexPath.row
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TableViewController.cellNum = indexPath.row
        // 画面遷移を行う
        performSegue(withIdentifier: "Segue", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

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
