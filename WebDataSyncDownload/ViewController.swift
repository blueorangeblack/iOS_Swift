//
//  ViewController.swift
//  WebDataSyncDownload
//
//  Created by min on 2021/04/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //다운로드 받을 URL 생성
        let imageAddr = "https://www.apple.com/v/imac-24/a/images/overview/color_front_blue__x3psx2ttezmi_large_2x.jpg"
        let imageUrl = URL(string: imageAddr)
        //동기적으로 다운로드 받기
        //Data는 예외처리를 반드시 해야하는 함수라서
        //try! 으로 예외가 발생하지 않는다고 설정
        let imageData = try! Data(contentsOf: imageUrl!)
        //다운로드 받은 데이터를 이미지로 변환
        let image = UIImage(data: imageData)
        //이미지 뷰에 출력
        imageView.image = image
        
//        //문자열을 다운로드 받을 URL 생성
//        let textAddr = "https://www.apple.com/imac-24/"
//        let textURL = URL(string: textAddr)
//        //문자열 다운로드
//        let textData = try! Data(contentsOf: textURL!)
//        //다운로드 받은 데이터를 문자열로 변환
//        let text = String(data: textData, encoding: .utf8)
//        //텍스트뷰에 출력
//        textView.text = text
        
        //문자열을 다운로드 받을 URL 생성
        let textAddr = "http://tjoeun.co.kr/"
        let textURL = URL(string: textAddr)
        //문자열 다운로드
        let textData = try! Data(contentsOf: textURL!)
        //다운로드 받은 데이터를 문자열로 변환
        //let text = String(data: textData, encoding: .utf8)
        //EUC-KR로 변환해서 생성
        let text = String(data: textData, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422)))
        //텍스트뷰에 출력
        textView.text = text
    }
}
