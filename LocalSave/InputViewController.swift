//
//  InputViewController.swift
//  LocalSave
//
//  Created by min on 2021/04/30.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var tfAppDelegate: UITextField!
    @IBOutlet weak var tfUserDefaults: UITextField!
    
    @IBAction func save(_ sender: Any) {
        //입력한 문자열 가져오기
        let name = tfAppDelegate.text
        let email = tfUserDefaults.text
        
        //AppDelegate에 저장
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.name = name!
        
        //환경 설정에 저장
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: "email")
        
        //자신을 출력한 뷰 컨트롤러로 이동
        let viewController = presentingViewController as! ViewController
        viewController.dismiss(animated: true){
            () -> Void in
            //출력하는 메소드 호출
            viewController.display()
        }
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
