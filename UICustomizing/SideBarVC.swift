//
//  SideBarVC.swift
//  UICustomizing
//
//  Created by min on 2021/05/12.
//

import UIKit

class SideBarVC: UITableViewController {
    //테이블 뷰에 출력할 텍스트와 이미지 프로퍼티
    let titles = ["새글", "친구", "달력", "공지", "통계", "계정"]
    
    let icons = [UIImage(named: "icon01.png"),
                 UIImage(named: "icon02.png"),
                 UIImage(named: "icon03.png"),
                 UIImage(named: "icon04.png"),
                 UIImage(named: "icon05.png"),
                 UIImage(named: "icon06.png")]
    
    //헤더 뷰를 위한 프로퍼티
    let profileImage = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //헤더 뷰로 사용할 뷰 생성
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.purple
        //테이블의 헤더 뷰로 설정
        self.tableView.tableHeaderView = headerView
        
        //헤더 뷰에 이름 출력하기
        nameLabel.frame = CGRect(x: 70, y: 15, width: 200, height: 30)
        nameLabel.text = "가나다"
        nameLabel.textColor = UIColor.white
        //nameLabel.font = UIFont.italicSystemFont(ofSize: 15)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.backgroundColor = UIColor.clear //투명하게
        headerView.addSubview(nameLabel)
        
        //헤더 뷰에 이메일 출력하기
        emailLabel.frame = CGRect(x: 70, y: 30, width: 200, height: 30)
        emailLabel.text = "abcde@xyz.com"
        emailLabel.textColor = UIColor.white
        emailLabel.font = UIFont.italicSystemFont(ofSize: 12)
        emailLabel.backgroundColor = UIColor.clear
        headerView.addSubview(emailLabel)
        
        //헤더 뷰에 이미지 출력하기
        profileImage.image = UIImage(named: "profile.jpg")
        profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        headerView.addSubview(profileImage)
        
        //이미지 뷰의 라운드 처리
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 0
        profileImage.layer.masksToBounds = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = self.titles[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.imageView?.image = self.icons[indexPath.row]

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //출력할 뷰 컨트롤러 생성
            let newWriteVC = self.storyboard?.instantiateViewController(identifier: "NewWriteVC") as! NewWriteVC
            //이동을 수행할 뷰 컨트롤러 찾아오기
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            //뷰 컨트롤러 이동
            target.pushViewController(newWriteVC, animated: true)
            //토글을 호출해서 테이블 뷰가 사라지도록 메소드 호출
            self.revealViewController()?.revealToggle(self)
        }
    }
}
