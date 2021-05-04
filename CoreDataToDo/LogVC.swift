//
//  LogVC.swift
//  CoreDataToDo
//
//  Created by min on 2021/05/04.
//

import UIKit

//데이터의 삽입, 수정, 삭제를 나타내기 위한 enum
//enum은 데이터를 제한하고자 할 때 사용
public enum LogType:Int16{
    case create = 0
    case edit = 1
    case delete = 2
}

//Int16 클래스에 기능을 추가
//swift나 kotlin, c#, javascript는 기존 클래스나 객체에 기능을 추가할 수 있음
//별도의 클래스를 만들 필요없음
extension Int16{
    func toLogType() -> String{
        switch  self {
        case 0: return "생성"
        case 1: return "수정"
        case 2: return "삭제"
        default: return ""
        }
    }
}

class LogVC: UITableViewController {
    //상위 뷰 컨트롤러에게서 넘겨받을 데이터
    var toDo:ToDoMO!
    
    //테이블 뷰에 출력할 데이터
    lazy var list:[LogMO]! = {
        return self.toDo.logs?.allObjects as! [LogMO]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LogCell")
        if cell == nil{
           cell = UITableViewCell(style: .default, reuseIdentifier: "LogCell")
        }
        
        //행 번호에 해당하는 데이터 찾아오기
        let log = list[indexPath.row]
        
        //출력
        cell?.textLabel?.text = "\(log.regdate!)에 \(log.type.toLogType())했습니다."
        
        return cell!
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
