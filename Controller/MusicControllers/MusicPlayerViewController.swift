//
//  MusicPlayerViewController.swift
//  TabBarDemo
//
//  Created by admin on 1/3/25.
//

import UIKit
import AVFoundation
//var auidioPLayer: AVAudioPlayer?

class MusicPlayerViewController: UIViewController{
    
    let userDefault = UserDefaults.standard
    
    var audioPlayer: AVAudioPlayer?
    
    var isPlayButton = true
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var playButtonImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let retrievedSongTitle = userDefault.string(forKey: "songTitle")
        songTitle.text = retrievedSongTitle
        let retrievedSongImage = userDefault.string(forKey: "songImage")
        musicImage.image =  UIImage(named: retrievedSongImage ?? "music-icon")
        createAudioPlayer()
    }
    
    func createAudioPlayer(){
        let songFileName = userDefault.string(forKey: "songLink")!
        
        //just wavs right now
        let bundlePath = Bundle.main.path(forResource: songFileName, ofType: "wav")!
        
        let url = URL(fileURLWithPath: bundlePath)
        
        do{
            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print("Error creating audio player: ", error)
        }
    }

    @IBAction func playButtonPress(_ sender: Any) {
        if(audioPlayer!.isPlaying){
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        
        if isPlayButton {
            playButtonImage.image = UIImage(systemName: "pause.circle.fill")
            isPlayButton = false
            print("Music is playing")
        } else {
            playButtonImage.image = UIImage(systemName: "play.circle.fill")
            isPlayButton = true
        }
    }
    
}
