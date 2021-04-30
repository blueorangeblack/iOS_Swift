//
//  MovieLinkVC.swift
//  AlamofireMovieList
//
//  Created by min on 2021/04/30.
//

import UIKit
import WebKit

class MovieLinkVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    //상위 뷰 컨트롤러에서 데이터를 넘겨받을 프로퍼티
    var link : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let addr = link{
            let url = URL(string: addr)
            let urlRequest = URLRequest(url: url!)
            webView.load(urlRequest)
        }
    }
}
