//
//  ViewController.swift
//  ImageViewAnimation
//
//  Created by min on 2021/04/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    //애니메이션에 사용할 이미지 배열
    var imgArray = [UIImage]()
    //현재 출력중인 이미지의 인덱스
    var i:Int?
    //애니메이션 속도 (실수로 설정해야 함)
    var speed:Float?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이미지 배열에 데이터 삽입
        imgArray.append(UIImage(named: "fruit0.jpg")!)
        imgArray.append(UIImage(named: "fruit1.jpg")!)
        imgArray.append(UIImage(named: "fruit2.jpg")!)
        imgArray.append(UIImage(named: "fruit3.jpg")!)
        imgArray.append(UIImage(named: "fruit4.jpg")!)
        
        i = 0
        speed = 0.5
        
        //이미지 뷰 초기화
        imgView.image = imgArray[i!]
        imgView.animationImages = imgArray
        
    }

    
    //이전 버튼
    @IBAction func goPrev(_ sender: Any) {
        i = i! - 1
//        방법1) 0 이전으로는 못가도록하기
//        if i! < 0{
//            i = 0
//        }
        //방법2) 0에서 이전누르면 가장 마지막으로 가서 연결되도록하기
        if i! < 0{
            i = imgArray.count - 1
        }
        imgView.image = imgArray[i!]
    }
    
    //다음 버튼
    @IBAction func goNext(_ sender: Any) {
        i = i! + 1
//        방법1_1) 마지막에서 더이상 안가고 멈추기 1
//        if i! == imgArray.count{
//            i = imgArray.count - 1
//        }
//        방법1_2) 마지막에서 더이상 안가고 멈추기 2
//        if i! > imgArray.count - 1{
//            i = imgArray.count - 1
//        }
        //방법2) 마지막에서 다음누르면 0으로 연결되도록하기
        if i! == imgArray.count {
            i = 0
        }
        imgView.image = imgArray[i!]
    }
    
    //시작 버튼
    @IBAction func goPlay(_ sender: Any) {
        //애니메이션을 중지 중인지 확인
        if imgView.isAnimating == false{
            //애니메이션 시간 설정
            imgView.animationDuration =
                TimeInterval(Int(speed! * 5) * imgArray.count)
            //애니메이션 시작
            imgView.startAnimating()
            //버튼의 타이틀 변경
            (sender as! UIButton).setTitle("중지", for: .normal)
        }else{
            //애니메이션 중지
            imgView.stopAnimating()
            //버튼의 타이틀 변경
            (sender as! UIButton).setTitle("시작", for: .normal)
        }
    }
    
    //슬라이더 변경
    @IBAction func changeSpeed(_ sender: Any) {
        //슬라이더의 값을 speed에 저장
        speed = slider.value
        //애니메이션 중이면 애니메이션을 멈추고 다시 시작
        if imgView.isAnimating == true {
            imgView.stopAnimating()
            //애니메이션 시간 설정
            imgView.animationDuration =
                TimeInterval(Int(speed! * 5) * imgArray.count)
            //애니메이션 시작
            imgView.startAnimating()
        }
    }
}

