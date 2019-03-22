//
//  ViewController.swift
//  DownloadMultipleFile
//
//  Created by Kondya on 22/03/19.
//  Copyright © 2019 Kondya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        processURLs()
    }
    
    func download(url: NSURL){
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        let downloadTask = session.downloadTask(with: url as URL)
        downloadTask.resume()
    }
    
    func processURLs(){
        
        //setup queue and set max conncurrent to 1
        let queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        
        let url1 = NSURL(string: "http://kathakids.pleximus.co/uploads/1/20181219172051S1P2.mp3")
        let url2 = NSURL(string: "http://kathakids.pleximus.co/uploads/1/20181219172051S1P2.mp3")
        let url3 = NSURL(string: "http://kathakids.pleximus.co/uploads/1/20181219172051S1P2.mp3")
        let url4 = NSURL(string: "http://kathakids.pleximus.co/uploads/1/20181219172051S1P2.mp3")
        
        let urls = [url1, url2,url3,url4]
        for url in urls {
            let operation = BlockOperation { () -> Void in
                print("starting download")
                self.download(url: url!)
            }
            
            queue.addOperation(operation)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //<#code#>
        
        print(location)
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        //
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        print("Progress \(downloadTask) \(progress)")
    }
    
}
