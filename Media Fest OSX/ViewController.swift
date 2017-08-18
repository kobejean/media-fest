//
//  ViewController.swift
//  Media Fest OSX
//
//  Created by Jean Flaherty on 8/11/15.
//  Copyright (c) 2015 mobileuse. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation

class ViewController: NSViewController {
    @IBOutlet weak var videoPlayerView: AVPlayerView!
    var timer: NSTimer! = NSTimer()
    @IBOutlet weak var timerText: NSTextField!
    var startTime: Float = 15900
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "stopWatch", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        //startCountdownVideo()
        //startStopWatch()
        videoPlayerView.hidden = true
        timerText.stringValue = getFormattedString()
        //timerText.layer?.zPosition = 1
        view.wantsLayer = true
        view.layer?.backgroundColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 1.0)
    }
    
    func getFormattedString() -> String{
        let t:Int = Int(self.startTime)
        let minQuotient:Int = t / 600
        let minRemainder:Int = t % 600
        let secQuotient:Int = minRemainder / 10
        let secRemainder:Int = minRemainder % 10
        
        let minString = "\(minQuotient)"
        var secString = "\(secQuotient)"
        
        if (secQuotient < 10){
            secString = "0\(secQuotient)"
        }
        let secRemainderString = "\(secRemainder)"
        
        if self.startTime < 100 {
            return "\(secQuotient)"
        }
        
        return "\(minString):\(secString)"
    }
    
    func startCountdownVideo() {
        let url = NSBundle.mainBundle().URLForResource("countdown2", withExtension: ".mov")
        videoPlayerView.player = AVPlayer(URL: url)
        videoPlayerView.player.play()
        videoPlayerView.hidden = false
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func startStopWatch(){
        dispatch_async(dispatch_get_main_queue(), {
            self.timer.invalidate()
            let timer = NSTimer(timeInterval: 0.1, target: self, selector: "stopWatch", userInfo: nil, repeats: true)
            self.timer = timer
        })
    }
    
    func stopStopWatch(){
        dispatch_async(dispatch_get_main_queue(), {
            self.timer.invalidate()
        })
    }
    
    func resetStopWatch(){
        self.startTime = 120
    }
    
    func stopWatch() {
        self.startTime = self.startTime - 1
        if self.startTime <= 60 {
            self.timer.invalidate()
            startCountdownVideo()
            videoPlayerView.hidden = false
            videoPlayerView.player.play()
        }
        timerText.stringValue = getFormattedString()
        //print(getFormattedString())
        
    }


}

