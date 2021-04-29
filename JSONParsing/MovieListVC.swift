//
//  MovieListVC.swift
//  JSONParsing
//
//  Created by min on 2021/04/29.
//

import UIKit

class MovieListVC: UITableViewController {

    var movies : Array<Dictionary<String,String>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "영화 목록"
        
        //데이터 다운로드
        let url = URL(string: "http://cyberadam.cafe24.com/movie/list")
        let data = try! Data(contentsOf: url!)
        //문자열로 변환 (데이터 다운로드 잘 됐는지 확인)
        //let jsonString = String(data: data, encoding: .utf8)
        //NSLog(jsonString!)
        
        //문자열을 디셔너리로 변환
        let movieResult = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        //list 키의 데이터를 배열로 변환
        let movieList = movieResult["list"] as! NSArray
        
        //배열의 데이터 순회
        for index in 0...(movieList.count - 1){
            let movie = movieList[index] as! NSDictionary
            //title 키와 thumbnail 키의 값을 문자열로 가져오기
            let title = movie["title"] as! String
            let image = movie["thumbnail"] as! String
            //가져온 데이터를 Dictionary로 생성한 후 배열에 저장
            let dict = ["title":title, "image":image]
            
            movies.append(dict)
        }
        //잘됐는지 확인
        //NSLog("\(movies)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        //행번호에 해당하는 데이터 가져오기
        let movie = movies[indexPath.row]
        
        cell?.textLabel?.text = movie["title"]
        
        let addr = movie["image"]!
        let imageUrl = "http://cyberadam.cafe24.com/movieimage/\(addr)"
        let url = URL(string: imageUrl)
        let imageData = try! Data(contentsOf: url!)
        let image = UIImage(data: imageData)
        cell?.imageView?.image = image

        return cell!
    }
}
