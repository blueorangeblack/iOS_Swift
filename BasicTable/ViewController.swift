//
//  ViewController.swift
//  BasicTable
//
//  Created by min on 2021/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //1)자료구조 변경
    //테이블 뷰에 출력할 문자열 배열
    //var fruits = [String]()
    
    //테이블 뷰에 출력할 이미지 이름 배열
    //var fruitsImage = [String]()
  
    //2)자료구조 변경
    //테이블 뷰에 출력할 데이터를 소유한 배열
    var fruits = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
/*
        //1)자료구조 변경
        //문자열 배열에 데이터 추가
        fruits.append("딸기")
        fruits.append("오렌지")
        fruits.append("바나나")
        fruits.append("라임")
        fruits.append("블루베리")
        fruits.append("복숭아")

        //이미지 파일 이름 저장
        fruitsImage.append("fruit0.jpg")
        fruitsImage.append("fruit1.jpg")
        fruitsImage.append("fruit2.jpg")
        fruitsImage.append("fruit3.jpg")
        fruitsImage.append("fruit4.jpg")
*/

        //2)자료구조 변경
        let dict1 = ["name":"딸기", "imageName":"fruit0.jpg", "eng":"strawberry"]
        let dict2 = ["name":"오렌지", "imageName":"fruit1.jpg", "eng":"orange"]
        let dict3 = ["name":"바나나", "imageName":"fruit2.jpg", "eng":"banana"]
        let dict4 = ["name":"라임", "imageName":"fruit3.jpg", "eng":"lime"]
        let dict5 = ["name":"블루베리", "imageName":"fruit4.jpg", "eng":"blueberry"]
        let dict6 = ["name":"복숭아", "imageName":"fruit0.jpg", "eng":"peach"]
        
        fruits.append(dict1)
        fruits.append(dict2)
        fruits.append(dict3)
        fruits.append(dict4)
        fruits.append(dict5)
        fruits.append(dict6)

 
        //테이블 뷰 사용을 위한 delegate와 dataSource속성 설정
        tableView.delegate = self
        tableView.dataSource = self
        
        //타이틀 설정
        self.title = "과일"
    }
}



//테이블 뷰 관련 메소드
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    //행의 개수를 설정하는 메소드 - 필수
    //section이 섹션(그룹) 번호
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    //셀의 모양을 설정하는 메소드 - 필수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀의 identifier로 사용할 문자열
        let cellIdentifier = "Cell"
        //재사용 가능한 셀이 있으면 찾아오기
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        //재사용 가능한 셀이 없으면 생성
        if cell == nil{
            cell = UITableViewCell (style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        //style: .default는 detailTextLabel 출력못해서 .subtitle로 바꿈
        
        //2)자료구조 변경
        //행 번호에 해당하는 데이터 찾아오기
        let dict = fruits[indexPath.row]
            
        //셀의 세부 속성 설정
        //문자열 배열의 데이터를 레이블에 출력
        //indexPath가 셀의 위치
        //indexPath.section은 그룹 번호
        //indexPath.row는 행 번호
        //1)자료구조 변경
        //cell?.textLabel!.text = fruits[indexPath.row]
        //2)자료구조변경
        cell?.textLabel?.text = dict["name"] as? String
        
        
        //이미지 출력
        //1)자료구조 변경
        //이미지 출력1. 문자열 데이터 갯수와 이미지 갯수가 같을 때
        //cell?.imageView?.image = UIImage(named: fruitsImage[indexPath.row])
        //이미지 출력2. 문자열 데이터 갯수보다 이미지 갯수가 부족할 때, 이미지를 번갈아가면서 출력
        //cell?.imageView?.image = UIImage(named: fruitsImage[indexPath.row % fruitsImage.count])
        //2)자료구조변경
        cell?.imageView?.image = UIImage(named: dict["imageName"] as! String)
        
        
        
        //보조 텍스트 출력
        //앞에서 설정한 UITableViewCell style이 default이면 detailTextLabel 출력못함
        //1)자료구조 변경
/*
        if indexPath.row < 3 {
            cell?.detailTextLabel?.text = "맛있다"
        }else{
            cell?.detailTextLabel?.text = "상큼하다"
        }
 */
        //2)자료구조변경
        cell?.detailTextLabel?.text = dict["eng"] as? String

        
        //엑세서리 출력 (각 셀마다 오른쪽 옆에 생기는 그림)
        cell?.accessoryType = .detailDisclosureButton
         
        
        //셀의 색 지정. 홀수, 짝수 다르게
        if indexPath.row % 2 == 0 {
            cell?.backgroundColor = UIColor.yellow
        }else {
            cell?.backgroundColor = UIColor.systemPink
        }
         
        return cell!
    }

    
    //행의 높이를 설정하는 메소드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //행의 들여쓰기를 설정하는 메소드 (홀수, 짝수 들여쓰기 다르게)
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.row % 2 == 0 {
            return 2
        }else{
            return 1
        }
    }
 
    
    //셀을 선택했을 때 호출되는 메소드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1)자료구조 변경
        //let alert = UIAlertController(title: "선택한 이름", message: fruits[indexPath.row], preferredStyle: .alert)
        //2)자료구조 변경
        let alert = UIAlertController(title: "선택한 이름", message: fruits[indexPath.row]["name"] as? String, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
