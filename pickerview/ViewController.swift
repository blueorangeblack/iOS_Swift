//
//  ViewController.swift
//  pickerview
//
//  Created by min on 2021/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    //출력할 텍스트를 배열로 생성
    var job = ["BackEnd", "FrontEnd", "Full Stack", "SI", "SM",
              "Database", "DevOps", "Visualization Artist",
              "Data Analyst", "ML Pos"]
    
    //이미지 이름 배열
    var imageNames = [String]()
    //이미지 배열
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이미지 파일 이름 배열 초기화
        imageNames.append("fruit0.jpg")
        imageNames.append("fruit1.jpg")
        imageNames.append("fruit2.jpg")
        imageNames.append("fruit3.jpg")
        imageNames.append("fruit4.jpg")
        
        //이미지 배열 초기화
        for temp in imageNames {
            images.append(UIImage(named: temp)!)
        }
        
        
        //출력을 하기 위해서 필요한 메소드는 self에서 찾아서 사용
        pickerView.dataSource = self
        //이벤트 처리를 하기 위해서 필요한 메소드는 self에서 찾아서 사용
        pickerView.delegate = self
    }


}

//피커 뷰 출력을 위한 DataSource(필수)와 Delegate(선택) 메소드를 생성
extension ViewController:UIPickerViewDataSource, UIPickerViewDelegate{
    //열의 개수를 설정하는 메소드 - 필수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //열 별로 행의 개수를 설정하는 메소드 - 필수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return job.count
        return imageNames.count
    }
/*
    //출력할 문자열을 설정하는 메소드
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return job[row]
    }
*/
    //뷰를 출력하는 메소드
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //출력할 뷰를 생성
        let imageView = UIImageView(image: images[row])
        //너비와 높이를 설정
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        //출력을 설정
        return imageView
    }
    
    //높이를 설정하는 메소드
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 120
    }
    
    //피커 뷰의 선택이 변경되었을 때 호출되는 메소드
    //component : 열
    //row : 행
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //레이블에 선택한 항목을 출력
        //label.text = job[row]
        label.text = imageNames[row]
        imgView.image = images[row]
    }
}
