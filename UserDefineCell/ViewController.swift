//
//  ViewController.swift
//  UserDefineCell
//
//  Created by min on 2021/04/26.
//

import UIKit

class ViewController: UIViewController {

    //출력할 데이터 배열
    var ar : Array<Dictionary<String, String>> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터 초기화
        ar.append(["name":"딸기", "engName":"strawberry", "imageName":"fruit0.jpg"])
        ar.append(["name":"오렌지", "engName":"orange", "imageName":"fruit1.jpg"])
        ar.append(["name":"바나나", "engName":"banana", "imageName":"fruit2.jpg"])
        ar.append(["name":"라임", "engName":"lime", "imageName":"fruit3.jpg"])
        ar.append(["name":"블루베리", "engName":"blueberry", "imageName":"fruit4.jpg"])
        
        //테이블 뷰의 Delegate와 DataSource설정
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    //섹션의 개수를 설정하는 메소드 - 선택
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //섹션 별 행의 개수를 설정하는 메소드 - 필수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ar.count
    }
    //행 별로 셀을 설정하는 메소드 - 필수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1)기본 셀
        //let cellIdentifier = "Cell"
        //2)사용자 정의 셀
        let cellIdentifier = "FruitsCell"
        
        //1)재사용 가능한 셀을 찾아오기
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        //2)재사용 가능한 셀을 찾아오기 - 사용자 정의 셀로 형변환하기
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FruitsCell
        
        //1)기본 셀
        /*
        //셀이 없으면 생성
        if cell == nil {
            cell = UITableViewCell (style: .default, reuseIdentifier: cellIdentifier)
        }
        */
        
        //필요한 데이터 출력
        //행번호에 해당하는 데이터 찾아오기
        let dic = ar[indexPath.row]
        //1)기본 셀
        //cell?.textLabel?.text = dic["name"]
        //2)사용자 정의 셀
        cell?.lblName?.text = dic["name"]
        cell?.lblEng?.text = dic["engName"]
        cell?.imgView?.image = UIImage(named: dic["imageName"]!)
        
        return cell!
    }
    
    //셀의 높이를 설정하는 메소드 구현
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
