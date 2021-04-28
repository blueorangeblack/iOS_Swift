//
//  ViewController.swift
//  CarCollection
//
//  Created by min on 2021/04/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //출력할 이미지 파일의 이름들을 저장할 배열
    var images:Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CollectionView의 delegate와 dataSource 설정
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //이미지 파일 이름을 저장
        for i in 0...24{
            let imageName = String(format: "car%02i.jpg", i)
            images.append(imageName)
        }
        
        //컬렉션 뷰의 항목과 경계선 간격 설정
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}


extension ViewController : UICollectionViewDelegate,
                           UICollectionViewDataSource,
                           UICollectionViewDelegateFlowLayout{
    
    //셀의 개수를 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //셀의 모양을 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //디자인한 셀 찾아오기
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarContentCell", for: indexPath) as! CarContentCell
        //셀에 이미지 출력
        cell.imageView.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    //셀의 크기를 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellWidth = collectionView.frame.width / 3 - 1
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellWidth)
    }
    
    //셀 간의 상하 간격을 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //셀 간의 좌우 간격을 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //선택 중 일 때 호출되는 메소드
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        //인덱스를 가지고 현재 선택한 셀 찾아오기
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.cyan.cgColor
        cell?.layer.borderWidth = 3.0
    }
    
    //선택을 해제했을 때 호출되는 메소드
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = nil
        cell?.layer.borderWidth = 0.0
    }
    
    //선택을 하고 난 후 호출되는 메소드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.blue.cgColor
        cell?.layer.borderWidth = 5.0
    }
    
    //선택을 해제하고 난 후 호출되는 메소드
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = nil
        cell?.layer.borderWidth = 0.0
    }
    
    //섹션별 헤더와 푸터를 구현하는 메소드
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //출력할 뷰 생성
        var reusableView : UICollectionReusableView! = nil
        
        //헤더 뷰 설정
        //푸터 뷰로 하려면  UICollectionView.elementKindSectionFooter로 하면됨
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CarCollectionHeaderView", for: indexPath) as! CarCollectionHeaderView
            
            headerView.title.text = "Car Group \(indexPath.section + 1)"
            headerView.backgroundImage.image = UIImage(named: "header-banner.jpeg")
            reusableView = headerView
        }
        return reusableView
    }
    
    //섹션 수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
}
