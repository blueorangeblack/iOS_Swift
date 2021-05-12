//
//  ViewController.swift
//  NavigationBarCustomizing
//
//  Created by min on 2021/05/12.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
/*
        //1) 기본 속성 이용
        //네비게이션바의 중앙이나 탭바 아이템에 문자열로 출력됨
        self.title = "타이틀"
        //바버튼아이템 생성
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
        //leftBarButtonItem은 1개, leftBarButtonItems는 여러 개
        //self.navigationItem.leftBarButtonItem = barButtonItem
        self.navigationItem.leftBarButtonItems = [barButtonItem]
*/
/*
        //2) 직접 뷰를 생성해서 네비게이션 바에 배치
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        //속성 설정
        nTitle.numberOfLines = 2
        nTitle.textAlignment = .center
        nTitle.textColor = UIColor.white
        nTitle.font = UIFont.systemFont(ofSize: 15)
        nTitle.text = "iOS\nNavigationBarCustomizing"
        self.navigationItem.titleView = nTitle
        
        let color = UIColor(red: 0.02, green: 0.02, blue: 0.5, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = color
 */
        //3) 이미지를 네비게이션 바에 배치
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let image = UIImage(named: "apple.png")
        imageView.image = image
        self.navigationItem.titleView = imageView
     
        
        //4) AlertController에 MapView 출력해보기
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        //대화상자에 출력할 뷰 컨트롤러 생성
        let contentVC = UIViewController()
        //맵 뷰 생성
        let mapKitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        //맵 뷰를 컨트롤러의 뷰로 설정
        contentVC.view = mapKitView
        
        //뷰 크기 변경
        contentVC.preferredContentSize.height = 300
        
        //alert.setValue(value: Any?, forKey: String)
        alert.setValue(contentVC, forKey: "contentViewController")
        
        present(alert, animated: true)
    }


}

