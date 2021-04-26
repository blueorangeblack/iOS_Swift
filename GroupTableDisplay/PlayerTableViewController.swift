//
//  PlayerTableViewController.swift
//  GroupTableDisplay
//
//  Created by min on 2021/04/26.
//

import UIKit

class PlayerTableViewController: UITableViewController {

    //기본 데이터를 저장할 프로퍼티 - 문자열 배열
    var data:Array<String> = []
    
    //섹션 별로 분류한 데이터를 저장할 프로퍼티 - 디셔너리 배열
    var sectionData:Array<Dictionary<String, Any>> = []
    
    //분류할 때 사용할 인덱스를 저장할 프로퍼티 - 문자열 배열
    var indexes:Array<String> = []
    
    //문자열을 매개변수로 받아서 첫번째 글자의 자음을 리턴하는 사용자 정의 메소드
    func subtract (data:String) -> String {
        //"나"와 비교
        var result = data.compare("나")
        //"나"보다 작으면 "ㄱ"으로 시작하는 글자
        if result == ComparisonResult.orderedAscending{//Ascending 오르는, 위를 향한
            return "ㄱ"
        }
        result = data.compare("다")
        if result == ComparisonResult.orderedAscending{
            return "ㄴ"
        }
        result = data.compare("라")
        if result == ComparisonResult.orderedAscending{
            return "ㄷ"
        }
        result = data.compare("마")
        if result == ComparisonResult.orderedAscending{
            return "ㄹ"
        }
        result = data.compare("바")
        if result == ComparisonResult.orderedAscending{
            return "ㅁ"
        }
        result = data.compare("사")
        if result == ComparisonResult.orderedAscending{
            return "ㅂ"
        }
        result = data.compare("아")
        if result == ComparisonResult.orderedAscending{
            return "ㅅ"
        }
        result = data.compare("자")
        if result == ComparisonResult.orderedAscending{
            return "ㅇ"
        }
        result = data.compare("차")
        if result == ComparisonResult.orderedAscending{
            return "ㅈ"
        }
        result = data.compare("카")
        if result == ComparisonResult.orderedAscending{
            return "ㅊ"
        }
        result = data.compare("타")
        if result == ComparisonResult.orderedAscending{
            return "ㅋ"
        }
        result = data.compare("파")
        if result == ComparisonResult.orderedAscending{
            return "ㅌ"
        }
        result = data.compare("하")
        if result == ComparisonResult.orderedAscending{
            return "ㅍ"
        }
        return "ㅎ"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //샘플데이터 입력
        data.append("박용택")
        data.append("켈리")
        data.append("오지환")
        data.append("라모스")
        data.append("양현종")
        data.append("김용의")
        data.append("양의지")
        data.append("류현진")
        data.append("이정후")
        data.append("유강남")
        data.append("전준우")
        data.append("추신수")
        data.append("박건우")
        data.append("수아레즈")
        data.append("홍창기")
        data.append("페르난데스")
        data.append("채은성")
        data.append("최정")
        data.append("김선빈")
        data.append("김현수")
        data.append("로켓")
        data.append("정수빈")
        data.append("서건창")
        data.append("이형종")
        data.append("나성범")
        data.append("김광현")
        data.append("데스파이네")
        data.append("고우석")
        data.append("구자욱")
        data.append("임찬규")
        data.append("손아섭")
        data.append("강민호")
        data.append("황재균")
        
        //인덱스 생성
        indexes.append("ㄱ")
        indexes.append("ㄴ")
        indexes.append("ㄷ")
        indexes.append("ㄹ")
        indexes.append("ㅁ")
        indexes.append("ㅂ")
        indexes.append("ㅅ")
        indexes.append("ㅇ")
        indexes.append("ㅈ")
        indexes.append("ㅊ")
        indexes.append("ㅋ")
        indexes.append("ㅌ")
        indexes.append("ㅍ")
        indexes.append("ㅎ")
        
        //data에 있는 데이터들을 첫글자의 자음별로 분류해서 sectionData에 대입
        
        //각 자음별로 데이터를 임시로 저장할 2차원 배열을 생성
        //14번을 Array()를 호출해서 배열로 생성
        var temp : [[String]] = Array(repeating: Array(), count: 14)
        
        var i = 0
        while i < indexes.count{
            //ㄱ부터 ㅎ까지 firstName에 순서대로 대입
            let firstName = indexes[i]
            //data 순회
            var j = 0
            while j < data.count{
                //첫글자의 자음가져오기
                let str = data[j]
                //첫글자의 자음과 firstName이 같으면
                if firstName == subtract(data: str){
                    temp[i].append(str)
                }
                j = j + 1
            }
            i = i + 1
        }
        
        //분류된 데이터를 내부적으로 정렬
        i = 0
        while i < temp.count{
            if temp[i].count >= 2 {
                temp[i].sort()
            }
            i = i + 1
        }
        
        
        //데이터가 존재하는 것만 첫번째 글자와 배열을
        //디셔너리로 묶어서 sectionData에 추가
        i = 0
        while i < indexes.count {
            //배열에 데이터가 있는 경우만
            if temp[i].count > 0 {
                let dic : Dictionary<String, Any> =
                    ["section_name":indexes[i],"data":temp[i]]
                sectionData.append(dic)
            }
            
            i = i + 1
        }
    }

    // MARK: - Table view data source

    //섹션의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    //섹션의 헤더를 만들어주는 메소드
    //헤더에 자음 출력
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //섹션 번호 디셔너리 찾아오기
        let dic = sectionData[section]
        //디셔너리에서 section_name 의 값 가져오기
        //Array는 직접 변환이 안되지만 String은 직접 변환 가능
        let str = dic["section_name"] as! String
        return str
    }

    //섹션 별로 행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //섹션 번호에 해당하는 데이터 찾아오기
        let dic = sectionData[section]
        //배열 데이터를 찾아와서 개수를 리턴
        let players = (dic["data"] as! NSArray) as Array
        
        return players.count
    }

    //셀의 모양을 설정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        //섹션 번호를 이용해서 Dictionary를 찾고
        let dic = sectionData[indexPath.section]
        
        //Dictionary에서 배열을 찾고
        let players = (dic["data"] as! NSArray) as Array
        
        //배열에서 행 번호를 가지고 데이터 찾아오기
        let player = players[indexPath.row] as! String
        
        //데이터 출력
        cell?.textLabel?.text = player
        
        return cell!
    }
    

}
