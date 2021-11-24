//
//  ViewController.swift
//  Repeat Alarm
//
//  Created by Collins on 4/11/17.
//  Copyright © 2017 Collins. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

//This is a test for 1234-new bug
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, GADBannerViewDelegate  {
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var mybanner: GADBannerView!
    
    var secondstt = 0
    var timer = Timer()
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var a = 1
    var b = 1
    var c = 1
    var originaltime = 0
    
   
    @IBOutlet weak var stopbtn: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func stop(_ sender: Any) {
        
        
        timer.invalidate()
        secondstt = 0
        label.text = ""
        
        audioPlayer.stop()
        startbtn.isHidden = false
        stopbtn.isHidden = true

        
        
    }
    
    
    @IBOutlet weak var startbtn: UIButton!
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
    var timedet = [["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"], ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"], ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]]
    
    
    
    
    @IBAction func start(_ sender: Any) {
        secondstt = originaltime
        if secondstt != 0 {
            
            let (h,m,s) = secondsToHoursMinutesSeconds(seconds: secondstt)
            
            label.text = String(h) + " Hours, " +  String(m) + " Minutes, " + String(s) + " Seconds"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        
        startbtn.isHidden = true
        stopbtn.isHidden = false
        
        }
    }
    
    
    
    
    func counter()
    {
        if secondstt != 0 {
                        secondstt -= 1
                        
                        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: secondstt)
                        
                        label.text = String(h) + " Hours, " +  String(m) + " Minutes, " + String(s) + " Seconds"
                        
                        if (secondstt == 0)
                        {
                            audioPlayer.numberOfLoops = 9
                            audioPlayer.play()
                            
                        }
        } else {
            
            
            
                        secondstt = originaltime
                        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: secondstt)
                        
                        label.text = String(h) + " Hours, " +  String(m) + " Minutes, " + String(s) + " Seconds"
                        
            }
    }
    
    @IBOutlet weak var stopOutlet: UIButton!

    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        mybanner.adUnitID = "ca-app-pub-6375630922509581/7721151157"
        
        mybanner.rootViewController = self
        mybanner.delegate = self
        mybanner.load(request)
        
        
        
        do{
            
            let audioPath = Bundle.main.path(forResource: "1", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch{
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timedet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timedet[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timedet[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
    }
    
    func updateLabel() {
        let hr = timedet[0][myPicker.selectedRow(inComponent: 0)]
        let min = timedet[1][myPicker.selectedRow(inComponent: 1)]
        let sec = timedet[2][myPicker.selectedRow(inComponent: 2)]

        
        textLabel.text = hr + " Hours, " + min + " Minutes, " + sec + " Seconds"
        
        a = Int(hr)!
        b = Int(min)!
        c = Int(sec)!
        
        secondstt = (a * 60 * 60) + (b * 60) + c
        secondstt = Int(secondstt)
        originaltime = secondstt
        
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: secondstt)

        
        
    }
    
}



