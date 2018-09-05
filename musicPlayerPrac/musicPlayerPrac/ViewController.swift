//
//  ViewController.swift
//  musicPlayerPrac
//
//  Created by user on 2018. 9. 3..
//  Copyright © 2018년 user. All rights reserved.
//
import Alamofire
import UIKit
import AVFoundation
import MediaPlayer
import SwiftyJSON

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var pnpBtn: UIButton!
    @IBOutlet weak var musicTime: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    var player : AVPlayer!
    
    let arr = ["1", "2", "3", "4"]
    
    var indexNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APready(musicName: arr[indexNum])
        
        musicSlider.maximumValue = Float(audioPlayer.duration)
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func APready(musicName: String){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: musicName, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do{
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            }
            catch{
                print(error)
            }
        }
        catch{
            print(error)
        }
        
        musicSlider.maximumValue = Float(audioPlayer.duration)
        musicSlider.value = 0
        
        
        audioPlayer.delegate = self
        
    }
    
    @IBAction func previousBtn(_ sender: Any) {
        if(audioPlayer.currentTime > 3){
            audioPlayer.currentTime = 0
            audioPlayer.play()
        }
        else{
            indexNum = chkOver(num: indexNum - 1)
            APready(musicName: arr[indexNum])
            audioPlayer.play()
        }
        pnpBtn.setTitle("pause", for: UIControlState.normal)
    }
    
    @IBAction func pnpBtn(_ sender: Any) {
        if(audioPlayer.isPlaying){
            audioPlayer.pause()
            pnpBtn.setTitle("play", for: UIControlState.normal)
            
        }
        else{
            audioPlayer.play()
            pnpBtn.setTitle("pause", for: UIControlState.normal)
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        indexNum = chkOver(num: indexNum + 1)
        APready(musicName: arr[indexNum])
        pnpBtn.setTitle("pause", for: UIControlState.normal)
        audioPlayer.play()
    }
    
    func chkOver(num: Int) -> Int {
        if(num == 4){
            return 0
        }
        else if(num == -1){
            return 3
        }
        else{
            return num
        }
    }
    
    @IBAction func stopBtn(_ sender: Any) {
        audioPlayer.currentTime = 0
        audioPlayer.stop()
        pnpBtn.setTitle("play", for: UIControlState.normal)
    }
    
    @IBAction func musicSlider(_ sender: Any) {
        audioPlayer.currentTime = TimeInterval(musicSlider.value)
    }
    
    //slider and text changes by time
    @objc func updateSlider(){
        let temp1 = Int(audioPlayer.currentTime)
        let temp2 = Int(audioPlayer.duration)
        
        musicSlider.value = Float(audioPlayer.currentTime)
        
        musicTime.text = "\(temp1 / 60):\(temp1 % 60) / \(temp2 / 60):\(temp2 % 60)"
        
    }
    
    // reaction by audioPlayer.delegate = self
    func audioPlayerDidFinishPlaying(_ _player: AVAudioPlayer, successfully flag: Bool){
        nextBtn.sendActions(for: .touchUpInside)
    }
    
    
    //not completed function
    @IBAction func getMusicBtn(_ sender: Any) {
        
        let url = "https://indi-list.com/api/getmusic/"
        let para : Parameters = [ "mid" : "57305"]
        let headers = ["x-access-token" : "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6InF3ZXIxMjM0IiwiZXhwIjoxNTY3NjQyMzk1LCJleHBfcmVmcmVzaCI6MTUzNjEwOTk5NSwiaWF0IjoxNTM2MTA2Mzk0fQ.N6QcZplSLW2flSBwDV2EIzG2aSZteX7s_xFYYubc8_AP4Xq6VpTJtWw4wKMxrf6TrAtu2TKTwpl21o1Q3Fqb_FgbPVYrYPJwGDa3tUAbcxi_YUxEhSr1q9ltIwkeNbyDn0a0glf-hHeNe02RXl37HXEmo9K5_FTnPC7y_FpoRpE"]
        
        Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseJSON { response in
            
            print(response)
            print("아아아")
            
            let swiftyJsonVar : JSON
            
            //to parse the JSON
            if((response.result.value) != nil) {
                swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar[0]["CloudFront-Policy"])
                print(swiftyJsonVar[1]["CloudFront-Signature"])
                print(swiftyJsonVar[2]["CloudFront-Key-Pair-Id"])
                print(swiftyJsonVar[3]["music"])
                print(swiftyJsonVar[4]["lyrics"])
                
                let musicUrl = URL(string: (swiftyJsonVar[3]["music"].string!))
                let musicItem = AVPlayerItem(url: musicUrl!)
                self.player = AVPlayer(playerItem: musicItem)
                self.player.play()
            }
            
        }
        
        
        
    }
    
    
}

