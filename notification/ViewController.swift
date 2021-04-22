//
//  ViewController.swift
//  notification
//
//  Created by min on 2021/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showAlert(_ sender: Any) {
        //대화상자 생성
        let alert = UIAlertController(title: "대화 상자", message: "안녕하세요?", preferredStyle: .alert)
        
        //UIAlertAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) ->  Void)?)
        //버튼 추가 방법 1)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil) //handler: nil 이면 생략해도 됨
        alert.addAction(cancel)
        //버튼 추가 방법 2)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { (_) in NSLog("확인을 누르셨습니다.")})
        
        //대화상자 출력
        present(alert, animated: true)
        
        //이 코드는 대화상자가 출력되자마자 수행됨
        NSLog("대화상자가 없어지기 전에 수행")
    }
    
    
    
    @IBOutlet weak var label: UILabel!
    @IBAction func login(_ sender: Any) {
        //대화상자 생성 (텍스트필드를 넣을 때는 보통 title이나 message중에 하나 생략함)
        let alert = UIAlertController(title: nil, message: "로그인", preferredStyle: .alert)
        
        //텍스트 필드 추가
        //alert.addTextField(configurationHandler: ((UITextField) -> Void)?)
        alert.addTextField(configurationHandler:
                            {(tf) -> Void in
                                tf.placeholder = "아이디를 입력해주세요"
                                tf.isSecureTextEntry = false
        })
        alert.addTextField(configurationHandler:
                            {(tf) -> Void in
                                tf.placeholder = "비밀번호를 입력해주세요"
                                tf.isSecureTextEntry = true
        })
        
        //버튼 추가
        alert.addAction(UIAlertAction(title: "취소", style: .cancel)) // 취소는 보통 핸들러 만들필요 없음
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(_) -> Void in
            //첫번째 텍스트 필드에 입력한 내용 가져오기
            let id = alert.textFields?[0].text
            //두번째 텍스트 필드에 입력한 내용 가져오기
            let pw = alert.textFields?[1].text
            
            if id == "abc" && pw == "1234" {
                NSLog("로그인 성공")
                self.label.text = "로그인 성공"
            } else {
                NSLog("로그인 실패")
                self.label.text = "로그인 실패"
            }
        }))
        
        //대화상자 출력
        present(alert, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

