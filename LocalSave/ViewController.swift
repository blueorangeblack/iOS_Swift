//
//  ViewController.swift
//  LocalSave
//
//  Created by min on 2021/04/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblAppDelegate: UILabel!
    @IBOutlet weak var lblUserDefaults: UILabel!
    
    @IBAction func add(_ sender: Any) {
        //네비게이션 컨트롤러를 이용하지 않고 하위 뷰 컨트롤러를 생성해서 출력
        let inputViewController = storyboard?.instantiateViewController(identifier: "InputViewController") as! InputViewController
        //출력
        present(inputViewController, animated: true)
    }
    
    //데이터 출력을 위한 함수
    func display(){
        //AppDelegate의 name 프로퍼티의 값을 lblAppDelegate에 출력
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        lblAppDelegate.text = appDelegate.name

        //UserDefaults의 email 프로퍼티 값을 lblUserDefaults에 출력
        if let email = (UserDefaults.standard).string(forKey:"email"){
            lblUserDefaults.text = email
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //데이터를 출력해주는 함수 호출
        display()
    }

    @IBAction func fileSave(_ sender: Any) {
        //documents 디렉토리 경로 만들기
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        
        //파일 경로 생성
        let dataFile = docsDir + "/fileName.txt"
        
        //파일에 기록할 내용
        let dataBuffer = "안녕하세요 스위프트".data(using: .utf8)
        
        //파일에 기록
        FileManager.default.createFile(atPath: dataFile, contents: dataBuffer, attributes: nil)
    }
    
    @IBAction func fileRead(_ sender: Any) {
        //documents 디렉토리 경로 만들기
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        
        //파일 경로 생성
        let dataFile = docsDir + "/fileName.txt"
        
        //파일의 내용 읽어오기
        let dataBuffer = FileManager.default.contents(atPath: dataFile)
        
        //문자열로 변환
        let msg = String(data: dataBuffer!, encoding: .utf8)
        
        //출력
        lblAppDelegate.text = msg
    }
}
