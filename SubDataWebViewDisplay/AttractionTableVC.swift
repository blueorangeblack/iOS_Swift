//
//  AttractionTableVC.swift
//  SubDataWebViewDisplay
//
//  Created by min on 2021/04/27.
//

import UIKit

class AttractionTableVC: UITableViewController {
    //테이블 뷰에 출력할 배열 생성
    var attractionData : Array<Dictionary<String,String>> = []
    
    //RefreshControl이 보여지면 호출되는 메소드
    @objc func handleRefresh(_ refreshControl:UIRefreshControl){
        //데이터 추가 - 맨 앞에 추가
        let dic1 = ["name":"그랜드캐년", "image":"grand_canyon.jpg",
                    "url":"https://en.wikipedia.org/wiki/Grand_Canyon"]
        let dic2 = ["name":"윈저궁", "image":"windsor_castle.jpg",
                    "url":"https://en.wikipedia.org/wiki/windsor_castle"]
        
        attractionData.insert(dic1, at: 0)
        attractionData.insert(dic2, at: 0)
        
        //RefreshControl 제거
        refreshControl.endRefreshing()
        
        //애니메이션과 함께 데이터를 재출력
        tableView.beginUpdates()
        
        tableView.insertRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .right)
        
        tableView.endUpdates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dic1 = ["name":"버킹검 궁전", "image":"buckingham_palace.jpg",
                    "url":"http://en.wikipedia.org/wiki/Buckingham_Palace"]
        let dic2 = ["name":"에펠탑", "image":"eiffel_tower.jpg",
                    "url":"http://en.wikipedia.org/wiki/Eiffel_Tower"]
        let dic3 = ["name":"엠파이어 빌딩", "image":"empire_state_building.jpg",
                    "url":"http://en.wikipedia.org/wiki/Empire_State_Building"]
        
        attractionData.append(dic1)
        attractionData.append(dic2)
        attractionData.append(dic3)
        
        self.title = "가고 싶은 곳"
        
        //RefreshControl을 생성해서 부착
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self,
                                  action: #selector(handleRefresh(_:)), for: .valueChanged)
        //운영체제에 따라 다름
        if #available(iOS 10.0, *){
            tableView.refreshControl = refreshControl
        }else{
            tableView.addSubview(refreshControl!)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractionData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //사용자 정의 셀 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttractionTableCell") as! AttractionTableCell
        
        //행번호에 해당하는 출력할 데이터 찾아오기
        let dic = attractionData[indexPath.row]
        //label에 name 출력
        cell.attractionLabel.text = dic["name"]
        //imageView에 image 출력
        cell.attractionImage.image = UIImage(named: dic["image"]!)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
        }
    
    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택한 행 번호에 해당하는 데이터 가져오기
        let dic = attractionData[indexPath.row]
        //url 키의 값 가져오기
        let url = dic["url"]
        
        //출력할 하위 뷰 컨트롤러 객체 생성
        let detailVC = storyboard?.instantiateViewController(identifier: "AttractionDetailVC") as! AttractionDetailVC
        //데이터 전달
        detailVC.webAddress = url
        
        //네비게이션 컨트롤러를 이용해서 하위 뷰 컨트롤러 출력하기
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //마지막에서 스크롤했는지 여부를 저장할 프로퍼티
    var flag = false
    
    //셀 들이 보여질 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if flag == false && indexPath.row == attractionData.count - 1{
            flag = true
        }else if(flag == true && indexPath.row == attractionData.count - 1){

            //데이터 추가 - 맨 앞에 추가
            let dic1 = ["name":"그랜드캐년", "image":"grand_canyon.jpg",
                        "url":"https://en.wikipedia.org/wiki/Grand_Canyon"]
            let dic2 = ["name":"윈저궁", "image":"windsor_castle.jpg",
                        "url":"https://en.wikipedia.org/wiki/windsor_castle"]

            attractionData.append(dic1)
            attractionData.append(dic2)

            tableView.reloadData()
        }
    }
    
}
