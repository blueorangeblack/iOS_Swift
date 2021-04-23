//
//  SecondViewController.swift
//  iOSProject
//
//  Created by min on 2021/04/23.
//

import UIKit

class SecondViewController: UIViewController {

    //메인화면에서 전달받은 데이터
    var subData:String! = nil
    
    @IBOutlet weak var lblSecond: UILabel!
    @IBAction func moveMain(_ sender: Any) {
        //자신을 출력할 뷰 컨트롤러로 돌아가기
        
        //자신을 출력한 뷰 컨트롤러 찾아오기
        let viewController = presentingViewController as! ViewController
        
        //데이터 전달
        viewController.mainData = "전달하는 데이터"
        
        viewController.dismiss(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if subData != nil {
            lblSecond.text = subData
        }
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
