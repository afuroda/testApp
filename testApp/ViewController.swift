//
//  ViewController.swift
//  testApp
//
//  Created by 山口航輝 on 02/04/20.
//  Copyright © 2020 koki.yamaguchi. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    let myLocation = CLLocationManager()
    
    
    //位置情報取得を初回のみ動かす用
    var firstFlag = false
    
    //urlに入力する用の検索時の緯度経度
    var mylatitude = String()
    var mylongitude = String()
    
    //範囲選択用配列
    let rangeList = ["検索範囲 300m","検索範囲 500m","検索範囲 1km","検索範囲 2km","検索範囲 3km"]
    //範囲選択用変数
    var rangeCount = 1
    
//    店の情報を格納する用の変数
    static var storeInfoName = NSMutableArray()
    static var storeInfoPic = NSMutableArray()
    static var storeAdress = NSMutableArray()
    static var storeNum = NSMutableArray()
    static var storeTime = NSMutableArray()
    static var storeStation =  NSMutableArray()
    static var storeStationExit = NSMutableArray()
    static var storeWalk = NSMutableArray()
    static var storePr = NSMutableArray()
    
    //ヒット数の格納用変数
    static var storeHit = Int()
    
    var storeLatitude = NSMutableArray()
    var storeLongitude = NSMutableArray()

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var rangePicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.rangePicker.delegate = self
        self.rangePicker.dataSource = self
        self.myLocation.delegate = self
        
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.notDetermined{
            myLocation.requestAlwaysAuthorization()
        }
        
        myLocation.startUpdatingLocation()
        
           
        makeSearchBtn()
        makeShowAllBtn()
        
        
}
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rangeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rangeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rangeCount = row + 1
        print(rangeCount)
    }
    
    
    
    func locationManager(_ maneger:CLLocationManager, didUpdateLocations: [CLLocation]){
        let myLocation = didUpdateLocations.last! as CLLocation
        
        let currentLocation = myLocation.coordinate
        
        if firstFlag == false{
            let mySpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                   let myRegion = MKCoordinateRegion(center: currentLocation, span: mySpan)
                   mapView.region = myRegion
            
            //フラグの書き換え
            firstFlag = true
        }
       
        let myLatitudeStr = String(myLocation.coordinate.latitude)
        mylatitude = myLatitudeStr
            
        let myLongitudeStr = String(myLocation.coordinate.longitude)
        mylongitude = myLongitudeStr
              
        
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("現在地の取得に失敗しました")
    }
    
    @objc func toShow(){
        self.performSegue(withIdentifier: "toShow", sender: nil)
    }
    
    
    
   
    
    //検索ボタン
    func makeSearchBtn(){
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width/6, height: self.view.bounds.height/20))
        
        searchBtn.layer.position = CGPoint(x: self.view.bounds.width/1.5, y: self.view.bounds.height * 0.9)
        
        searchBtn.setTitle("検索", for: .normal)
        searchBtn.setTitleColor(.black, for: .normal)
        searchBtn.layer.borderWidth = 2
        searchBtn.layer.cornerRadius = self.view.bounds.width/30
        searchBtn.backgroundColor = .orange
        searchBtn.addTarget(self, action: #selector(search), for: .touchUpInside)
        self.view.addSubview(searchBtn)
    }
    
    //一覧ボタン
    func makeShowAllBtn(){
        let showAllBtn =  UIButton(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width/6, height: self.view.bounds.height/20))
        showAllBtn.layer.position = CGPoint(x: self.view.bounds.width/2.5, y: self.view.bounds.height * 0.9)
        showAllBtn.setTitle("一覧", for: .normal)
        showAllBtn.setTitleColor(.black, for: .normal)
        showAllBtn.layer.borderWidth = 2
        showAllBtn.backgroundColor = .orange
        showAllBtn.layer.cornerRadius = self.view.bounds.width/30
        showAllBtn.addTarget(self, action: #selector(toShow), for: .touchUpInside)
        self.view.addSubview(showAllBtn)
    }
    
    
    
    //searchBtnメソッド
    @objc func search(){
        let urlString =  "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=16a6a7aa4221917d3068f3bd26c9b051&range=5&latitude=\(mylatitude)&longitude=\(mylongitude)&range=\(rangeCount)"
        
        let parcentUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: parcentUrl)!
        
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            
            do{
                let json = try JSON(data: data!)
                let hitPageNum = json["hit_per_page"].intValue
                print(json)
                
                for i in 0..<hitPageNum {
                    
                    self.storeLatitude[i] = json["rest"][i]["latitude"].doubleValue
                    self.storeLongitude[i] = json["rest"][i]["longitude"].doubleValue
                    ViewController.storeHit = json["total_hit_count"].intValue
                    ViewController.self.storeInfoName[i] = json["rest"][i]["name"].stringValue
                    ViewController.self.storeInfoPic[i] = json["rest"][i]["image_url"]["shop_image1"].stringValue
                    ViewController.self.storeAdress[i] = json["rest"][i]["address"].stringValue
                    ViewController.self.storeNum[i] = json["rest"][i]["tel"].stringValue
                    ViewController.storeTime[i] = json["rest"][i]["opentime"].stringValue
                    ViewController.storeStation[i] = json["rest"][i]["access"]["station"].stringValue
                    ViewController.storeStationExit[i] = json["rest"][i]["access"]["station_exit"].stringValue
                    ViewController.storeWalk[i] = json["rest"][i]["access"]["walk"].stringValue
                    ViewController.storePr[i] = json["rest"][i]["pr"]["pr_short"].stringValue
                }
                
                print(ViewController.self.storeInfoName.count)
            }
            catch{
                print("error")
            }
            
            
            for i in 0..<self.storeLatitude.count{
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(self.storeLatitude[i] as! CLLocationDegrees,self.storeLongitude[i] as! CLLocationDegrees)
                self.mapView.addAnnotation(annotation)
                print(annotation)
            }
        })
        
        task.resume()
    }
    
}

