//
//  AttractionDetailVC.swift
//  SubDataWebViewDisplay
//
//  Created by min on 2021/04/27.
//

import UIKit
import WebKit

class AttractionDetailVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    //상위 뷰 컨트롤러로 부터 데이터를 넘겨받을 프로퍼티
    var webAddress : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //넘겨받은 주소를 webView에 출력
        if let address = webAddress{
            let url = URL(string: address)
            let urlRequest = URLRequest(url: url!)
            webView.load(urlRequest)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
