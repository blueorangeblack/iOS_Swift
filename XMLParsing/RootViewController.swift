//
//  RootViewController.swift
//  XMLParsing
//
//  Created by min on 2021/04/28.
//

import UIKit

class RootViewController: UITableViewController {
    //태그 안의 내용을 저장할 프로퍼티
    var elementValue : String!
    //하나의 객체를 저장할 프로퍼티
    var book : Book!
    //파싱한 모든 데이터를 저장할 프로퍼티
    var books : Array<Book> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //다운로드 받을 URL을 생성
        let url = URL(string: "http://sites.google.com/site/iphonesdktutorials/xml/Books.xml")
        //파서 객체 생성
        let xmlParser = XMLParser(contentsOf: url!)
        //파싱을 위임
        xmlParser?.delegate = self
        let success = xmlParser?.parse()
        //XMLParserDelegate의 메소드를 구현한 객체 설정
        if success == true {
            self.title = "파싱 성공"
        }else{
            self.title = "파싱 실패"
        }
        //NSLog("books : \(books)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }

        //행 번호에 해당하는 데이터 가져오기
        let book = books[indexPath.row]
        //출력
        cell?.textLabel?.text = book.title
    
        return cell!
    }
}

extension RootViewController : XMLParserDelegate{
    //태그가 시작될 때 호출되는 메소드
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //객체를 생성하는 키를 만났을 때 파싱한 데이터를 저장할 객체를 생성
        //속성이 있다면 속성을 저장
        if elementName == "Book"{
            book = Book()
            
            let dic = attributeDict as Dictionary
            book.bookId = dic["id"]
        }
    }
    
    //태그 안의 내용을 만났을 때 호출되는 메소드
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //처음 호출되는 것인지 아니면 연속해서 호출되는 것인지 판단해서
        //처음 호출되는 것이면 문자열을 바로 대입하지만
        //그렇지 않다면 문자열을 기존 문자열에 추가
        if elementValue == nil{
            elementValue = string
        }else{
            elementValue = "\(elementValue!)\(string)"
        }
    }
    
    //닫는 태그를 만났을 때 호출되는 메소드 - 여기서 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Books"{
            return
        }
        if elementName == "Book"{
            //배열에 데이터를 저장
            books.append(book)
        }else{
            //세부 태그가 종료될 때 문자열을 속성에 저장
            if elementName == "title"{
                book.title = elementValue
            }else if elementName == "author"{
                book.author = elementValue
            }else if elementName == "summary"{
                book.summary = elementValue
            }
            elementValue = nil
        }
    }
}
