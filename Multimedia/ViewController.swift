//
//  ViewController.swift
//  Multimedia
//
//  Created by min on 2021/05/11.
//

import UIKit
import AVFoundation
import AVKit
import Alamofire

class ViewController: UIViewController{
    //오디오 재생기
    var audioPlayer : AVAudioPlayer?

    @IBAction func audioPlay(_ sender: Any) {
        //오디오를 백그라운드에서도 재생할 수 있도록 옵션 추가
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSession.Category.playback, mode: .default, policy: .longFormAudio, options:[])
        }catch let error{
            NSLog(error.localizedDescription)
        }
        
        //오디오 재생
        if let player = audioPlayer{
            player.play()
        }
    }
    @IBAction func audioStop(_ sender: Any) {
        if let player = audioPlayer{
            player.stop()
        }
    }
    @IBAction func changeVolumn(_ sender: Any) {
        if let player = audioPlayer{
            let slider = sender as! UISlider
            player.volume = slider.value
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //초기화 작업
        //노래 파일의 경로 생성

        //1) 번들에 있는 파일 재생
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "PAIX PER MIL-1-0.000", ofType: "mp3")!, relativeTo: nil)
        //재생기 생성
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        //prepareToPlay() 재생준비
        audioPlayer?.prepareToPlay()
 
        //2) 스트리밍 재생 - 오류나는 상황
/*
        let url = URL(string: "http://cyberadam.cafe24.com/song/if.mp3")
        //재생기 생성
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        //prepareToPlay() 재생준비
        audioPlayer?.prepareToPlay()
 */
/*
        //3) 내장 사운드 파일의 경로 생성
        //시뮬레이터에서는 안됨
        let path = "System/Library/Audio/UISounds/SIMToolKitGeneralBeep.caf"
        //let path = "System/Library/Audio/UISounds/ReceivedMessage.caf"
        //복사할 파일 경로 생성 (documentDierctory경로)
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        let file = docsDir + "/test.caf" //이름 상관없음
        
        //파일 복사
        try! FileManager.default.copyItem(atPath: path, toPath: file)
        
        //오디오 재생을 위한 URL과 재생기 준비
        let url = URL(fileURLWithPath: file, relativeTo: nil)
        //재생기 생성
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        //prepareToPlay() 재생준비
        audioPlayer?.prepareToPlay()
*/
    }
    

    //세그웨이를 이용해서 이동할 때  호출되는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //목적지 가져오기
        let destination = segue.destination as! AVPlayerViewController
        //비디오 파일의 URL을 생성
        let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")
        //재생
        destination.player = AVPlayer(url: url!)
    }
    
    //코드로 재생 버튼 눌렀을 때 호출되는 메소드
    @IBAction func videoPlay(_ sender: Any) {
        //동영상 파일의 경로 생성
        let filePath = Bundle.main.path(forResource: "IPhone3G", ofType: "mov")
        let url = URL(fileURLWithPath: filePath!)
        
        //재생기 생성
        let player = AVPlayer(url: url)
        //재생기를 사용할 비디오 재생 뷰 컨트롤러 생성
        let playerController = AVPlayerViewController()
        //비디오 재생 컨트롤러에 재생기 연결
        playerController.player = player
        
        //현재 뷰 컨트롤러에 비디오 재생 뷰 컨트롤러를 자식으로 넣고
        //기존 뷰 위에 비디오 재생 뷰 컨트롤러의 뷰를 배치
        addChild(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        
        //비디오 재생
        player.play()
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func pick(_ sender: Any) {
        //이미지 피커 컨트롤러를 생성하고 옵션을 설정
        let picker = UIImagePickerController()
        //sourceType 어디서 가져올건지
        // 시뮬레이터에서는 photoLibrary로 하고, 실기기에서는 camera로 해도 됨
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true //이미지 편집 기능
        
        //UIImagePickerController에서 이벤트가 발생하면 호출할 메소드의 위치를 설정
        picker.delegate = self
        
        //출력
        present(picker, animated: true)
    }
    
    @IBAction func upload(_ sender: Any) {
        //업로드할 URL : http://IP주소/ite/insert
        //전송 방식 : POST
        //파일 업로드 여부 : 있음
        //파라미터 : itemname, description, price, pictureurl(파일)
        //헤더 : 없음
        //결과 형식 : json
        //결과 해석 : {result:true 또는 false}
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //이미지를 선택하지 않고 취소 버튼을 눌렀을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false){() in
            let alert = UIAlertController(title: "이미지 피커", message: "이미지를 선택하지 않았습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    //이미지를 선택하고 확인 버튼을 눌렀을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: false) {() in
            //선택한 이미지를 이미지 뷰에 출력
            //info가 이미지를 가지고 있음
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imageView.image = img
        }
    }
}
