//
//  Naver.swift
//  LoginTest
//
//  Created by 김희중 on 2020/07/03.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire

public class Naver {
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    func getNaverInfo(completed: @escaping (_ userInfo:NaverModel) -> Void)  {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }

        if !isValidAccessToken {
            return
        }
            

        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
            
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!

        let authorization = "\(tokenType) \(accessToken)"

        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])

        req.responseJSON { response in
        guard let result = response.value as? [String:Any] else { return }
//            print(result)
                
            let userInfo = NaverModel()
        
            guard let object = result["response"] as? [String: Any] else { return }
            guard let age = object["age"] as? String else { return }
            guard let birthday = object["birthday"] as? String else { return }
            guard let gender = object["gender"] as? String else { return }
            guard let id = object["id"] as? String else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            guard let nickname = object["nickname"] as? String else { return }
            guard let profImageUrl = object["profile_image"] as? String else { return }
            
//            let userInfo = NaverModel(id: id, age_range: age, birthday: birthday, email: email, gender: gender, name: name, nickname: nickname, profile_image_url: profImageUrl)
            userInfo.age_range = age
            userInfo.birthday = birthday
            userInfo.gender = gender
            userInfo.id = id
            userInfo.name = name
            userInfo.email = email
            userInfo.nickname = nickname
            userInfo.profile_image_url = profImageUrl
            
            completed(userInfo)
        }
    }
}
