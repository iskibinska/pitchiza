//
//  ViewController.swift
//  PitchIza
//
//  Created by Izabela Skibinska on 12/26/15.
//  Copyright © 2015 Irma. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewWillAppear(animated: Bool) {
     
        stopButton.hidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stop(sender: UIButton) {
        
        recordingInProgress.hidden = true;
        recordButton.enabled = true
       
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
        
        
    }

    @IBAction func recordAudio(sender: UIButton) {
        
      
        stopButton.hidden=false;
        recordingInProgress.hidden = false;
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
            
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        
        if (segue.identifier == "stopRecording")
        {
            
            let playSoundVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundVC.receivedAudio = data
        }
    }
    
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if (flag) {
            
        recordedAudio = RecordedAudio()
        recordedAudio.filePathUrl = recorder.url
         
        recordedAudio.title = recorder.url.lastPathComponent
        

        self.performSegueWithIdentifier("stopRecording",sender: recordedAudio)
        
        } else {
            
            recordButton.enabled = true;
            stopButton.hidden = true
        }
    }
}

