//
//  HomePageController.swift
//  swiftText
//
//  Created by jingjun on 2018/7/11.
//  Copyright © 2018年 景军. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
import RxSwift


class HomePageController: UIViewController {

    fileprivate var cityArr : [CityModel] = []
    
    
    let provinceIndex = Variable<Int?>(nil)
    let cityIndex = Variable<Int?>(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let net = MoyaProvider<APIManager>()
        net.request(APIManager.location) { (result) in
            switch result {
            case .success(let responce):
                print(responce.data)
                let json = try? responce.mapJSON()
                let data = json as? [String: Any?]
                let cityData = data!["data"] as? [[String: Any?]]
                let model = JSONDeserializer<CityModel>.deserializeModelArrayFrom(array: cityData)
                print(model!)
                self.cityArr = model! as! [CityModel]
            case .failure(let error):
                print(error)
            }
        }
    
        
        

        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let second = HomeSecondController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(second, animated: true)
        self.hidesBottomBarWhenPushed = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

