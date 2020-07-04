//
//  ViewController.swift
//  LoginTest
//
//  Created by 김희중 on 2020/07/01.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    let cellid = "cellid"
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    lazy var naverCollectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    lazy var loginButton: UILabel = {
        let label = UILabel()
        label.text = "login"
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(login)))
        return label
    }()
    
    lazy var logoutButton: UILabel = {
        let label = UILabel()
        label.text = "logout"
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logout)))
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        naverCollectionview.register(naverCell.self, forCellWithReuseIdentifier: cellid)
        
        view.addSubview(loginButton)
        view.addSubview(logoutButton)
        view.addSubview(naverCollectionview)
        
        loginButton.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 50)
        logoutButton.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: 50)
        naverCollectionview.frame = CGRect(x: 0, y: 230, width: view.frame.width, height: view.frame.height - 230)
    }
    
    @objc func login() {
        print("login button clicked")
        loginInstance?.delegate = self
        
        loginInstance?.requestThirdPartyLogin()
    }
    
    @objc func logout() {
        print("log out!")
        loginInstance?.requestDeleteToken()
    }
    
    var keyArray = ["연령대: ","생일: ","이메일: ","성별: ","id: ","이름: ","별명: ", "프로필이미지url: "]
    var userInfoArray = [String]()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! naverCell
        cell.naverInfoText.text = keyArray[indexPath.item] + userInfoArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userInfoArray.count
    }
    
    
    
}

extension ViewController: NaverThirdPartyLoginConnectionDelegate {
    // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
      func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
    //     let naverSignInVC = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
    //     naverSignInVC.parentOrientation = UIInterfaceOrientation(rawValue: UIDevice.current.orientation.rawValue)!
    //     present(naverSignInVC, animated: false, completion: nil)
        
        // UIWebView가 제거되면서 NLoginThirdPartyOAuth20InAppBrowserViewController가 있는 헤더가 삭제되었습니다.
        // 해당 코드 없이도 로그인 화면이 잘 열리는 것을 확인.
      }
      
      // 로그인에 성공했을 경우 호출
      func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        let naver = Naver()
        naver.getNaverInfo { [weak self] (naver) in
            self?.userInfoArray.removeAll()
            self?.userInfoArray.append(naver.age_range!)
            self?.userInfoArray.append(naver.birthday!)
            self?.userInfoArray.append(naver.email!)
            self?.userInfoArray.append(naver.gender!)
            self?.userInfoArray.append(naver.id!)
            self?.userInfoArray.append(naver.name!)
            self?.userInfoArray.append(naver.nickname!)
            self?.userInfoArray.append(naver.profile_image_url!)
            
            self?.naverCollectionview.reloadData()
        }
      }
      
      // 접근 토큰 갱신
      func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("이미 로그인 되어 있습니다.")
      }
      
      // 로그아웃 할 경우 호출(토큰 삭제)
      func oauth20ConnectionDidFinishDeleteToken() {
        loginInstance?.requestDeleteToken()
      }
      
      // 모든 Error
      func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Error] :", error.localizedDescription)
      }
}

class naverCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let naverInfoText: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    fileprivate func setupLayouts() {
        backgroundColor = .white
        addSubview(naverInfoText)
        naverInfoText.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
}

