//
//  AppDelegate.swift
//  SQLitePhoneBook
//
//  Created by min on 2021/05/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //데이터베이스 파일 경로 생성
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0] as String
        let dbPath = docsDir.appending("/phonebook.sqlite")
        
        //파일 관리 객체 생성
        let fileMgr = FileManager.default
        
        //데이터베이스 파일이 없다면 파일을 생성
        //** SQL을 잘못 작성해도 파일은 생성됨
        //SQL을 잘못 작성해서 에러가 발생했다면 수정한 후 앱을 지우고 다시 설치해야 함
        if fileMgr.fileExists(atPath: dbPath) == false{
            //데이터베이스 접속
            let contactDB = FMDatabase(path: dbPath)
            //데이터베이스를 열고 테이블 생성 구문을 실행
            if contactDB.open(){
                let sql = "CREATE TABLE IF NOT EXISTS phonebook(num INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT, addr TEXT)"
                if contactDB.executeStatements(sql){
                    NSLog("테이블 생성 성공")
                }else{
                    NSLog("테이블 생성 실패")
                }
                contactDB.close()
            }else{
                NSLog("Error:\(contactDB.lastErrorMessage())")
            }
        }
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

