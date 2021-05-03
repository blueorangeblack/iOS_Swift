//
//  PhoneBookListVC.swift
//  SQLitePhoneBook
//
//  Created by min on 2021/05/03.
//

import UIKit

class PhoneBookListVC: UITableViewController {
    //테이블 뷰에 출력할 데이터 배열
    var phoneBook:[(num:Int, name:String, phone:String, addr:String)]!
    //DAO 객체
    let dao = PhoneBookDAO()
    
    @IBAction func add(_ sender: Any) {
        //대화상자 생성
        let alert = UIAlertController(title: "신규 등록", message: "등록할 연락처를 입력하세요!", preferredStyle: .alert)
        
        //입력란 만들기
        //alert.addTextField(configurationHandler: ((UITextField) -> Void)?)
        //alert.addTextField{((UITextField) -> Void)?}
        //alert.addTextField{(UITextField) in ?}
        alert.addTextField(){(tf) in tf.placeholder = "이름"}
        alert.addTextField(){(tf) in tf.placeholder = "전화번호"}
        alert.addTextField(){(tf) in tf.placeholder = "주소"}
        
        //버튼 추가
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        //alert.addAction(UIAlertAction(title: "확인", style: .default, handler: ((UIAlertAction) -> Void)?))
        alert.addAction(UIAlertAction(title: "확인", style: .default){(_) in
            //입력한 내용 가져오기
            let name = alert.textFields?[0].text
            let phone = alert.textFields?[1].text
            let addr = alert.textFields?[2].text
            
            //데이터 삽입
            if self.dao.create(name: name, phone: phone, addr: addr){
                //데이터 다시 가져오기
                self.phoneBook = self.dao.find()
                //테이블 뷰 다시 출력
                self.tableView.reloadData()
                
                //네비게이션의 타이틀 뷰도 다시 출력
                let naviTitle = self.navigationItem.titleView as! UILabel
                naviTitle.text = "연락처\n총 \(self.phoneBook.count) 개"
            }
        })
        //대화상자 출력
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //전체 데이터 불러오기
        phoneBook = self.dao.find()
        //UI 초기화
        
        //네비게이션 바의 중앙에 출력할 데이터
        let naviTitle = UILabel (frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        naviTitle.numberOfLines = 2
        naviTitle.textAlignment = .center
        naviTitle.font = UIFont.systemFont(ofSize: 14)
        naviTitle.text = "연락처\n총 \(self.phoneBook.count) 명"
        self.navigationItem.titleView = naviTitle
        
        //네비게이션 바의 왼쪽에 편집 버튼 추가
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        //셀을 스와이프할 때 편집 모드가 되도록 설정
        self.tableView.allowsSelectionDuringEditing = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBook.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PHONE_CELL"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        //행 번호에 해당하는 데이터 가져오기
        let record = phoneBook[indexPath.row]
        
        //데이터 출력
        cell?.textLabel?.text = record.name
        cell?.detailTextLabel?.text = "\(record.phone)\(record.addr)"

        return cell!
    }

    //Edit 버튼을 누를 때 아이콘을 설정하는 메소드
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //Edit 버튼을 누르고 난 후 삭제 버튼을 누르면 호출되는 메소드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //데이터를 삭제
        
        //삭제할 데이터의 번호 찾아오기
        let num = self.phoneBook[indexPath.row].num
        
        //데이터 삭제
        if self.dao.remove(num: num){
            self.phoneBook.remove(at: indexPath.row)
            //삭제하는 애니메이션 적용
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            //네비게이션의 타이틀 뷰도 다시 출력
            let naviTitle = self.navigationItem.titleView as! UILabel
            naviTitle.text = "연락처\n총 \(self.phoneBook.count) 개"
        }
    }
}
