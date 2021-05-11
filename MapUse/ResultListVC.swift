//
//  ResultListVC.swift
//  MapUse
//
//  Created by min on 2021/05/10.
//

import UIKit
import MapKit

class ResultListVC: UITableViewController {
    //이전 뷰 컨트롤러로 부터 데이터를 넘겨받을 프로퍼티
    var mapItem:[MKMapItem]?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //mapItem이 nil이면 0
        return mapItem?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell")
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ResultCell")
        }
        //데이터 찾아와서 출력하기
        if let item = mapItem?[indexPath.row]{
            cell?.textLabel?.text = item.name
            cell?.detailTextLabel?.text = item.phoneNumber
        }
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //RouteVC 클래스의 객체를 생성
        
        let routeVC = self.storyboard?.instantiateViewController(identifier: "RouteVC") as! RouteVC
        let destination = mapItem?[indexPath.row]
        routeVC.destination = destination
        self.navigationController?.pushViewController(routeVC, animated: true)
    }

}
