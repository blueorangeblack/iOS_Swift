//
//  ViewController.swift
//  scrollviewuse
//
//  Created by min on 2021/04/22.
//

import UIKit

class ViewController: UIViewController {

    var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이미지 객체 생성
        let image:UIImage! = UIImage(named: "large.jpg")
        //이미지 뷰 생성
        imageView = UIImageView(image: image)
        //이미지뷰를 터치할 수 있도록 설정
        imageView.isUserInteractionEnabled = true
        
        //이미지 뷰 크기를 저장
        let imageSize = imageView!.frame.size
        
        //스크롤 뷰를 화면 전체 크기로 생성
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        
        //스크롤 뷰 옵션 설정
        scrollView.isScrollEnabled = true
        
        //내용의 크기 설정
        scrollView.contentSize = imageSize
        
        //바운스 속성을 설정
        scrollView.bounces = false
        
        scrollView.addSubview(imageView)
        
        //이미지 뷰를 현재 뷰 컨트롤러에 배치
        //self.view.addSubview(imageView)
        self.view.addSubview(scrollView)
        
        
        
        //줌 관련 설정
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 0.5
        scrollView.delegate = self
    }

}


extension ViewController : UIScrollViewDelegate {
    //확대 축소가 발생할 뷰를 설정하는 메소드
    func viewForZooming(in scrollView: UIScrollView)
        -> UIView? {
            return imageView
    }
}
