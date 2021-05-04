//
//  ToDoListVC.swift
//  CoreDataToDo
//
//  Created by min on 2021/05/03.
//

import UIKit
import CoreData

class ToDoListVC: UITableViewController {
    //데이터 저장을 위한 메소드
    func save(title:String, contents:String, runtime:Date) -> Bool{
        //코어 데이터 사용을 위한 저장소를 가져오기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //데이터 삽입
        let object = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(runtime, forKey: "runtime")
        
        //Log 데이터 삽입
        //삽입할 데이터 객체를 생성
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        //데이터를 설정
        logObject.regdate = Date()
        logObject.type = LogType.create.rawValue
        
        //1:N 관계의 데이터 삽입
        (object as! ToDoMO).addToLogs(logObject)
        
        do{
            //데이터 삽입
            try context.save()
            self.list.append(object)
            self.list = self.fetch()
            return true
        }catch{
            context.rollback()
            return false
        }
    }
    
    //전체 데이터를 읽어오는 메소드
    //데이터베이스를 사용할 때 DAO 클래스의 역할을 수행하는 객체로
    //AppDelegate 클래스의 persistentContainer.viewContext를 이용해서 사용 가능
    //ManagedObject 클래스는 VO(DTO)의 역할을 수행
    func fetch() -> [NSManagedObject]{
        //코어 데이터 사용을 위한 저장소를 가져오기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //요청 객체 생성 - ToDo Entity의 데이터 가져오도록 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDo")
        //데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        
        return result
    }
    
    //코어 데이터 삭제를 위한 메소드
    func delete(object:NSManagedObject) -> Bool {
        //데이터 편집을 위한 관리 객체 컨텍스트 생성
        //코어 데이터 사용을 위한 저장소 가져오기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //데이터 삭제
        context.delete(object)
        
        //저장소에 반영
        do{
            try context.save() //save()는 commit
            return true
        }catch{
            context.rollback()
            return false
        }
    }
    
    //데이터 수정을 위한 메소드
    func edit(object:NSManagedObject, title:String, contents:String, runtime:Date) -> Bool{
        //데이터 편집을 위한 관리 객체 컨텍스트 생성
        //코어 데이터 사용을 위한 저장소 가져오기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //객체의 내용 수정
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(runtime, forKey: "runtime")
        
        //Log 데이터 삽입
        //삽입할 데이터 객체를 생성
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        //데이터를 설정
        logObject.regdate = Date()
        logObject.type = LogType.edit.rawValue
        
        //1:N 관계의 데이터 삽입
        (object as! ToDoMO).addToLogs(logObject)
        
        do{
            //데이터를 반영
            try context.save()
            self.list = self.fetch()
            return true
        }catch{
            context.rollback()
            return false
        }
    }
    
    
    //읽어온 데이터를 저장할 배열
    lazy var list : [NSManagedObject] = {
        return self.fetch()
    }()
    
    @IBAction func add(_ sender: Any) {
        //출력할 뷰 컨트롤러 생성
        let toDoInputVC = self.storyboard?.instantiateViewController(identifier: "ToDoInputVC") as! ToDoInputVC
        
        //수정 작업 추가시)
        //삽입과 수정 모드를 구분하기 위한 프로퍼티 설정 (기본이 삽입이라서 이건 안해도 상관은 없음)
        toDoInputVC.mode = "삽입"
        
        self.navigationController?.pushViewController(toDoInputVC, animated: true)
        
    }
    
    //뷰가 만들어질 때 호출되는 메소드
    //맨 처음 한번만 호출 - 안드로이드에서는 onCreate
    override func viewDidLoad() {
        super.viewDidLoad()
//        let alert = UIAlertController(title: "viewDidLoad", message: "뷰가 만들어질 때 호출되는 메소드", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default))
//        self.present(alert, animated: true)
        //맨 처음 한 번만 수행할 내용을 작성
        self.title = "ToDo"
        //네비게이션 바의 왼쪽에 edit 버튼 배치
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        //셀을 스와이프 할 때 삭제할 수 있도록 해주는 설정
        self.tableView.allowsSelectionDuringEditing = true
    }
    
    //뷰가 화면에 보여질 때 호출되는 메소드
    //다른 뷰에 가려졌다가 보여질 때 마다 호출됨 - 안드로이드에서는 onResume
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let alert = UIAlertController(title: "viewWillAppear", message: "뷰가 보여질 때 호출되는 메소드", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default))
//        self.present(alert, animated: true)
        //보여질 때 마다 수행할 내용을 작성
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ToDoCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        //데이터 찾아오기
        let record = list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        //출력하기
        cell?.textLabel?.text = title
        cell?.detailTextLabel?.text = contents

        return cell!
    }
    
    //edit버튼을 눌렀을 때 호출되는 메소드 (delete 기능을 하는 - 모양의 버튼이 생김)
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //edit버튼을 누르고 - 버튼을 누른 후 delete 버튼을 눌렀을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //삭제할 데이터 찾아오기
        let object = self.list[indexPath.row]
        //데이터 삭제
        if self.delete(object: object){
            //데이터 목록에서 삭제
            self.list.remove(at: indexPath.row)
            //삭제 애니메이션 실행
            self.tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
    //셀을 선택했을 때 호출되는 메소드 - 수정을 위해서 ToDoInputVC를 호출
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //넘겨줄 데이터 찾아오기
        let object = self.list[indexPath.row]
        
        //각각의 데이터 찾아오기
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        let runtime = object.value(forKey: "runtime") as? Date
        
        //ToDoInputVC 클래스의 객체 생성
        let toDoInputVC = self.storyboard?.instantiateViewController(identifier: "ToDoInputVC") as! ToDoInputVC
        
        //데이터 넘기기
        toDoInputVC.object = object
        toDoInputVC.t = title!
        toDoInputVC.c = contents!
        toDoInputVC.r = runtime!
        toDoInputVC.mode = "수정"
        
        //출력
        self.navigationController?.pushViewController(toDoInputVC, animated: true)
    }
    
    //셀의 엑세서리를 눌렀을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //데이터 찾아오기
        let object = list[indexPath.row]
        
        //출력할 하위 뷰 컨트롤러 생성
        let logVC = self.storyboard?.instantiateViewController(identifier: "LogVC") as! LogVC
        logVC.toDo = object as? ToDoMO
        
        //하위 뷰 컨트롤러 네비게이션 컨트롤러를 이용해서 출력
        self.navigationController?.pushViewController(logVC, animated: true)
    }
}
