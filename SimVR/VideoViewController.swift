//
//  VideoViewController.swift
//  SimVR
//
//  Created by Jessie Deot on 5/6/16.
//  Copyright © 2016 Jessie Deot. All rights reserved.
//

import UIKit
import Socket_IO_Client_Swift

class VideoViewController: UIViewController, GCSVideoViewDelegate {
    
    var kMargin: CGFloat!
    var kVideoViewHeight: CGFloat!
    var videoView: GCSVideoView!
    var isPaused: Bool! = nil
    
    
    @IBAction func logoutBarButton(sender: AnyObject) {
        
        self.performSegueWithIdentifier("logged_out", sender: sender)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor : UIColor = UIColor( red: 14/255, green: 61/255, blue:153/255, alpha: 1.0 )
        
        //logoutBtn.layer.borderColor = myColor.CGColor
        //logoutBtn.layer.borderWidth = 2.0
        //logoutBtn.layer.cornerRadius = 8.0
        //logoutBtn.layer.backgroundColor = myColor.CGColor
        
        self.kMargin = 50
        self.kVideoViewHeight = 250
        
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            //dispatch_async(dispatch_get_main_queue(), { () -> Void in
            print("MInfo: \(messageInfo)")
                
           // })
        }
        
        
        
        self.title = "Video"
        
        // Create a |GCSVideoView| and position in it in the top half of the view.
        self.videoView = GCSVideoView(frame: CGRectMake(16, 32, self.view.bounds.size.width - 32, 200))
        self.videoView.delegate = self
        self.videoView.enableFullscreenButton = true
        self.videoView.enableCardboardButton = true
        self.isPaused = false
        
        //let videoPath: String = "http://techslides.com/demos/sample-videos/small.mp4"
        //let videoPath: String = NSBundle.mainBundle().pathForResource("test", ofType: "mp4")!
        
        
        //videoView.loadFromUrl(NSURL.init(fileURLWithPath:videoPath))
        videoView.loadFromUrl(NSURL(string: "ec2-52-38-104-45.us-west-2.compute.amazonaws.com:3000/movie.mp4")!)
        
        self.view!.addSubview(videoView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //_videoView.frame = CGRectMake( 100, 200, _videoView.frame.size.width, _videoView.frame.size.height ); // set new position exactly
        self.videoView.frame = CGRectMake(kMargin, kMargin, CGRectGetWidth(self.view.bounds) - 2 * kMargin, kVideoViewHeight)
    }
    
    func widgetViewDidTap(widgetView: GCSWidgetView) {
        if (isPaused != nil) {
            videoView.resume()
        }
        else {
            videoView.pause()
        }
        self.isPaused = !isPaused
    }
    
    func videoView(videoView: GCSVideoView, didUpdatePosition position: NSTimeInterval) {
        // Rewind to beginning of the video when it reaches the end.
        if position == videoView.duration() {
            self.isPaused = true
            videoView.seekTo(0)
        }
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

