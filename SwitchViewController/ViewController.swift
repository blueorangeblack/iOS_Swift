//
//  ViewController.swift
//  SwitchViewController
//
//  Created by min on 2021/04/23.
//

import UIKit

class ViewController: UIViewController {
    //SecondViewController로 부터 데이터를 전달받을 프로퍼티
    var mainData : String!{
        //값이 변경될 때 호출되는 함수
        didSet{
            viewIfLoaded?.setNeedsLayout()
        }
    }
    
    //뷰를 출력할 때 호출되는 메소드 재정의
    override func viewWillLayoutSubviews() {
        if mainData != nil{
            labelMain.text = mainData
        }
    }
    
    @IBAction func push(_ sender: Any) {
        //네비게이션 컨트롤러를 이용해서 DetailViewController 출력
        
        //스토리보드에 디자인한 DetailViewController 객체 생성
        let detail = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    @IBOutlet weak var labelMain: UILabel!
    @IBAction func moveSecond(_ sender: Any) {
        //이동할 뷰 컨트롤러 객체 생성
        let secondViewController = self.storyboard?.instantiateViewController(
            identifier: "Second") as! SecondViewController
        
        //애니메이션 설정 (기본이 .coverVertical)
        secondViewController.modalTransitionStyle = .flipHorizontal
        
        //데이터 전달
        secondViewController.subData = "데이터 전달"
        
        //화면 이동
        present(secondViewController, animated: true)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "제목" //네이비게이션 바의 중앙에 출력
    }


    //세그웨이로 돌아오도록 하기 위한 메소드
    @IBAction func returned(segue:UIStoryboardSegue){
        labelMain.text = "세그웨이로 돌아왔습니다."
    }
    
    //세그웨이로 이동하기 전에 호출되는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //이동할 뷰 컨트롤러 찾아오기
        let destination = segue.destination as! SubViewController
        //destination에서 프로퍼티를 호출해서 넘겨주면 됨
        //destination.data = "세그웨이를 이용해서 이동했습니다."
    }
}

