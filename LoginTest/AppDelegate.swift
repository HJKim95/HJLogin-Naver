//
//  AppDelegate.swift
//  LoginTest
//
//  Created by 김희중 on 2020/07/01.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit
import NaverThirdPartyLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        // 네이버 앱으로 인증하는 방식을 활성화
        instance?.isNaverAppOauthEnable = false
        
        // SafariViewController에서 인증하는 방식을 활성화
        instance?.isInAppOauthEnable = true
        
        // 인증 화면을 iPhone의 세로 모드에서만 사용하기
        instance?.isOnlyPortraitSupportedInIphone()
        
        // 네이버 아이디로 로그인하기 설정
        // 애플리케이션을 등록할 때 입력한 URL Scheme
        instance?.serviceUrlScheme = kServiceAppUrlScheme
        
        // 애플리케이션 등록 후 발급받은 클라이언트 아이디
        instance?.consumerKey = kConsumerKey
        
        // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
        instance?.consumerSecret = kConsumerSecret
        
        // 애플리케이션 이름
        instance?.appName = kServiceAppName
        
        // 하나도 빠짐없이! 등록해주어야 창이 뜬다!!!
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
