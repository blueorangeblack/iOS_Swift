//
//  EditTableViewController.swift
//  EditTableView
//
//  Created by min on 2021/04/26.
//

import UIKit

class EditTableViewController: UITableViewController {
    //테이블 뷰에 출력할 문자열 배열
    var skills : Array<String> = []

    //네비게이션 바의 오른쪽 바 버튼을 눌렀을 때 호출되는 메소드
    @IBAction func addItem(_ sender: Any) {
        //대화상자 생성
        let alert = UIAlertController(title: "보유 기술 등록",
                                      message: "보유 기술을 입력하세요!", preferredStyle: .alert)
        
        //입력받을 텍스트 필드 추가
        //alert.addTextField(configurationHandler: ((UITextField) -> Void)?)
        alert.addTextField(configurationHandler: {(tf) -> Void in tf.placeholder = "보유 기술"})
        //버튼 추가
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: {(action) -> Void in
            //텍스트 필드에 입력한 텍스트 가져오기
            let skill = alert.textFields?[0].text
            //입력한 내용이 없으면 (입력한 내용이 닐 또는 공백을 트림한 후 글자수가 0 이면)
            if skill == nil || skill?.trimmingCharacters(in: .whitespaces).count == 0{
                return
            }
            //배열에 데이터를 추가 (insert는 맨 앞에 추가 / append는 맨 뒤에 추가)
            self.skills.insert(skill!, at: 0)
            
            //테이블 뷰를 다시 출력
            //1)애니메이션 적용안됨
            //self.tableView.reloadData()
            //2)애니메이션 적용되도록 수정
            //첫번째 행에 데이터를 삽입하는 애니메이션 적용
            self.tableView.beginUpdates()
            
            //self.tableView.insertRows(at: [IndexPath], with: UITableView.RowAnimation)
            //with에 원하는 스타일 적용 bottom, middle, left, right, top 등등 있음
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .middle)
            
            self.tableView.endUpdates()
        }))
        
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "보유 기술"
        
        skills.append("프로그래밍 언어 - 자바")
        skills.append("데이터베이스 - 오라클")
        skills.append("프레임워크 - 스프링")
        
        //네비게이션 바의 왼쪽에 edit 버튼 추가
        navigationItem.leftBarButtonItem = editButtonItem
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }

    //처음 만들면 주석처리되어있는데 주석지우고 코드 작성
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
        }
        cell?.textLabel?.text = skills[indexPath.row]

        return cell!
    }
    

    //테이블 뷰 컨트롤러에서 edit 버튼을 눌렀을 때 호출되는 메소드
    //아이콘 모양을 결정하는 메소드
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //1)Edit버튼 기능 수정 전. delete기능
        //return .delete
        //2)Edit버튼 기능 수정 - 셀 위치 변경
        return .none
    }
    
    //2)Edit버튼 기능 수정 - 셀 위치 변경
    //Edit 버튼을 눌렀을 때 들여쓰기를 설정하는 메소드 추가
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //2)Edit버튼 기능 수정 - 셀 위치 변경
    //셀을 선택하고 이동할 때 호출되는 메소드 추가
    //Edit 버튼을 누르면 삼선버튼이 보이고 이 버튼을 이용해서 드래그 앤 드랍하면 호출되는 메소드
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //선택한 항목의 데이터 찾아오기
        let movedObject = skills[sourceIndexPath.row]
        //기존의 위치에서 삭제
        skills.remove(at: sourceIndexPath.row)
        //이동할 위치에 추가
        skills.insert(movedObject, at: destinationIndexPath.row)
    }
    
    //edit 버튼을 눌러서 보여진 아이콘을 누를 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //행 번호에 해당하는 데이터를 삭제하고 테이블 뷰를 다시 출력
        self.skills.remove(at: indexPath.row)
        
        //1)애니메이션 적용안됨
        //self.tableView.reloadData()
        //2)애니메이션 적용되도록 수정
        self.tableView.beginUpdates()
        
        self.tableView.deleteRows(at: [indexPath], with: .right)
        
        self.tableView.endUpdates()
    }


}
