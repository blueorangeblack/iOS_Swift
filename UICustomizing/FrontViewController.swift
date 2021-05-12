//
//  FrontViewController.swift
//  UICustomizing
//
//  Created by min on 2021/05/12.
//

import UIKit

class FrontViewController: UIViewController {

    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let revealVC = self.revealViewController(){
            //버튼을 클릭할 때 동작을 설정
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(animated:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
}
