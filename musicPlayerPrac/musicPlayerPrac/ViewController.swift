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

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var pnpBtn: UIButton!
    @IBOutlet weak var musicTime: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    
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
    
    
}

