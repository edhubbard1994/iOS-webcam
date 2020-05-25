//
//  ViewController.swift
//  webcam_iOS
//
//  Created by Edward Hubbard on 5/16/20.
//  Copyright © 2020 Edward Hubbard. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var session: AVCaptureSession?
    var vidView: PreviewView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(AVCaptureDevice.authorizationStatus(for: .video).rawValue)
        self.getVideoWindow()
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (didComplete) in
            DispatchQueue.main.async {
                if (!didComplete) { return }
                if (self.startCamera() == false) {print("failure")}
                
                self.vidView?.videoPreviewLayer.session = self.session
                print(self.session?.outputs[0])
            }
            
            

            })
        
       
    }
    
    func getVideoWindow() -> Void {
        self.vidView = PreviewView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.vidView?.contentMode = UIView.ContentMode.scaleAspectFit
        //self.vidView?.videoPreviewLayer.session = self.session
        
        self.view.addSubview(self.vidView!)
    }
    
    func startCamera() -> Bool {
  
        
        self.session = AVCaptureSession()
        
        let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        guard
            let videoDeviceInput = try? AVCaptureDeviceInput(device: device!) as AVCaptureInput,
            self.session!.canAddInput(videoDeviceInput)
        else { return false }
        self.session!.addInput(videoDeviceInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        let soundOutput = AVCaptureAudioDataOutput()
        guard self.session!.canAddOutput(videoOutput) else { return false }
        guard self.session!.canAddOutput(soundOutput) else { return false }
        self.session!.sessionPreset = .vga640x480
        self.session!.addOutput(videoOutput)
        self.session!.addOutput(soundOutput)
        self.session!.commitConfiguration()
        self.session!.startRunning()
        return true
    }
    
}


class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}

