//
//  ViewController.swift
//  gesture
//
//  Created by min on 2021/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    //TapGesture가 사용할 selector (함수)
    @objc func tapGestureMethod(sender:UITapGestureRecognizer){
        if self.imgView.contentMode == UIView.ContentMode.scaleAspectFit{
            self.imgView.contentMode = UIView.ContentMode.center
        }else{
            self.imgView.contentMode = UIView.ContentMode.scaleAspectFit
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //제스처 객체 생성
        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(tapGestureMethod(sender:)))
        //세부 옵션 설정 (두 번 tap)
        tap.numberOfTapsRequired = 2
        //두 손가락 터치하는 경우로 설정하려면
        //tap.numberOfTouchesRequired = 2
        //뷰에 제스처 객체 설정
        imgView.addGestureRecognizer(tap)
    }


}

