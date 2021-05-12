//
//  CustomNavigationBar.swift
//  NavigationBarCustomizing
//
//  Created by min on 2021/05/12.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

    //높이를 위한 프로퍼티
    var customHeight : CGFloat = 300
    
    //뷰의 크기를 결정하는 메소드
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
    }

    //뷰를 출력해야 할 때 마다 호출되는 메소드
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //상태 표시줄의 높이
        let y = UIApplication.shared.statusBarFrame.height
        frame = CGRect(x: frame.origin.x, y: y, width: frame.size.width, height: customHeight)
        
        for subView in self.subviews{
            var stringFromClass = NSStringFromClass(subView.classForCoder)
            if stringFromClass.contains("BarBackground"){
                subView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                backgroundColor = backgroundColor
            }
            stringFromClass = NSStringFromClass(subView.classForCoder)
            if stringFromClass.contains("BarContent"){
                subView.frame = CGRect(x: subView.frame.origin.x, y: 20, width: subView.frame.width, height: customHeight)
                subView.backgroundColor = self.backgroundColor
            }
        }
    }
}
