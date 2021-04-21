//
//  ViewController.swift
//  controltest
//
//  Created by min on 2021/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    //키보드가 올라올 때 호출될 함수
    @objc func keyboardWillShow(notification:Notification) -> Void{
        //버튼의 현재 위치와 크기 가져오기
        let originalRect = button.frame
        //위치 이동
        button.frame = CGRect(x: originalRect.origin.x, y: originalRect.origin.y - 50, width: originalRect.width, height: originalRect.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //리소스로 추가한 이미지를 객체로 생성
        let image1 = UIImage(named: "btn_01.png")
        let image2 = UIImage(named: "btn_02.png")
        
        //setBackgroundImage(image: UIImage?, for: UIControl.State)
        button.setBackgroundImage(image1, for: .normal) // normal 보통 때
        button.setBackgroundImage(image2, for: .highlighted) // highlighted 누르고 있을 때
        
        //button.setTitle(title: String?, for: UIControl.state)
        button.setTitle("확인", for: .normal)
        button.setTitle("누름", for: .highlighted)
        
        //키보드 화면에 출력
        tfEmail.becomeFirstResponder()
        
        //delegate 설정
        //tfEmail에서 이벤트가 발생하면 이벤트 처리 메소드를
        //self(ViewController)에서 찾음
        tfEmail.delegate = self
        
        //노티피케이션과 함수 연결
        //NotificationCenter.default.addObserver(observr: Any, selector: Selector, name: NSNotification.Name?, object: Any?)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //노티피케이션과 클로저 연결
        //NotificationCenter.default.addObserver(forName: NSNotification.Name?, object: Any?, queue: OperationQueue?, using: (Notification) -> Void)
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){(Notification) -> Void in
            //버튼의 현재 위치와 크기 가져오기
            let originalRect = self.button.frame
            //위치 이동
            self.button.frame = CGRect(x: originalRect.origin.x, y: originalRect.origin.y + 50, width: originalRect.width, height: originalRect.height)
        }
    }

    @IBAction func click(_ sender: Any) {
        //NSLog("버튼 누름")
        lblEmail.text = tfEmail.text
        tfEmail.text=""
    }
    
    //터치가 발생할 때 호출되는 메소드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //키보드 제거
        tfEmail.resignFirstResponder()
    }
    
    //tfEmail에서 return키를 눌렀을 때 호출되는 함수
    @IBAction func returnPress(_ sender: Any) {
        tfEmail.resignFirstResponder()
    }
    
    //UITextFieldDelegate의 return을 누르면 호출되는 메소드
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        tfEmail.resignFirstResponder()
//        return true
//    }
}


extension ViewController : UITextFieldDelegate {
    //UITextFieldDelegate의 return을 누르면 호출되는 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfEmail.resignFirstResponder()
        return true
    }
}
