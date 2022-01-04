//
//  FirstVC.swift
//  SwipeTab
//
//  Created by min on 2021/05/12.
//

import UIKit

class FirstVC: UIViewController {
    @objc func buttonTapped(){
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        navigationController?.pushViewController(viewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()        
        let btn = UIButton()
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btn)
        btn.setTitle("Button", for: .normal)
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
