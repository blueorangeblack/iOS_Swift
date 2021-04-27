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
}
