//
//  ViewController.swift
//  imageSwipe
//
//  Created by min on 2021/04/22.
//

import UIKit

class ViewController: UIViewController {

    //스크롤 뷰
    var scrollView:UIScrollView!
    //스크롤 뷰에 내용이 될 뷰
    var contentView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //스크롤 뷰 생성 - 한 페이지의 좌표와 크기 설정
        scrollView = UIScrollView(frame: CGRect(x: 80, y: 100, width: 200, height: 200))
        //스크롤 뷰에 출력할 내용 설정
        //가로로 스와이프하기위해 scrollView의 width 200 * 이미지갯수 5 = 1000으로 설정
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 200))
        
        //반복문을 수행해서 contentView의 내용 만들기
        var t : Int = 0
        for i in 0...4{
            //이미지 뷰를 x 좌표를 변경하면서 생성
            let imageView = UIImageView(frame: CGRect(x: t, y: 0, width: 200, height: 200))
            //이미지 설정
            imageView.image = UIImage(named: "fruit\(i).jpg")
            //항목 뷰에 배치
            contentView.addSubview(imageView)
            //x좌표가 200씩 커짐
            t = t + 200
        }
        
        scrollView.addSubview(contentView)
        scrollView.contentSize = contentView!.frame.size
        self.view.addSubview(scrollView)
        scrollView.isPagingEnabled = true
    }


}

