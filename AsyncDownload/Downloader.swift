//
//  Downloader.swift
//  AsyncDownload
//
//  Created by min on 2021/04/29.
//

import UIKit

class Downloader: Thread {
    //출력을 위한 뷰 프로퍼티
    var imageView : UIImageView!
    var textView : UITextView!
    
    //스레드로 동작할 메소드
    override func main(){
        //main thread에서 하도록 수정)
        OperationQueue.main.addOperation{
            
        let textURL = URL(string: "https://www.apple.com/")
        let textData = try! Data(contentsOf: textURL!)
        let appleText = String(data: textData, encoding: .utf8)
        //NSLog(appleText!)
        //수정 전)
        //textView.text = appleText
        //수정 후)
        self.textView.text = appleText
        
        let imageURL = URL(string: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-family-select-2021?wid=940&amp;hei=1112&amp;fmt=jpeg&amp;qlt=80&amp;.v=1617135051000")
        let imageData = try! Data(contentsOf: imageURL!)
        let image = UIImage(data: imageData)
        //수정 전)
        //imageView.image = image!
        //수정 후)
        self.imageView.image = image!
        }
    }
}

