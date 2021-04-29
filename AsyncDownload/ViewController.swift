//
//  ViewController.swift
//  AsyncDownload
//
//  Created by min on 2021/04/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //스레드 객체 생성
        let thread = Downloader()
        thread.imageView = imageView
        thread.textView = textView
        //스레드 시작
        thread.start()
        
    }
}
