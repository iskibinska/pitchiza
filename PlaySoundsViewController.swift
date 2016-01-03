//
//  PlaySoundsViewController.swift
//  PitchIza
//
//  Created by Izabela Skibinska on 12/26/15.
//  Copyright © 2015 Irma. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//       if  var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType:"mp3")
//          {
//           let filePathUrl = NSURL.fileURLWithPath(filePath)
//            
//            
//
//          }
//        
//          else
//          {
//            print("the filePath is empty")
//            }
        
        
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true;
        
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        
    }
    
    @IBAction func stopAudioPlayer(sender: UIButton) {
        
           audioPlayer.stop()
        
        
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        
        audioPlayer.stop()
        audioPlayer.rate=1.5
        audioPlayer.play()
        
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        audioPlayer.stop()
        audioPlayer.rate=0.5
        audioPlayer.play()
    }
    
    
    func playAudioWithVariablePitch(pitch: Float)
    {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
        
        
    }
    
    
    @IBAction func DarthVader(sender: UIButton) {
        
           playAudioWithVariablePitch(-1000)
        
    }
    
    @IBAction func PlayChipmunk(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
