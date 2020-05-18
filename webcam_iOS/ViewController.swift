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
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (didComplete) in
            if (!didComplete) { return }
            self.startCamera()
        })
        getVideoWindow()
        self.session?.startRunning()
    }
    
    func getVideoWindow() -> Void {
        self.vidView = PreviewView()
        self.vidView?.videoPreviewLayer.session = self.session
    }
    
    func startCamera() -> Bool {
  
        
        self.session = AVCaptureSession()
        
        let device = AVCaptureDevice.default(.builtInDualCamera,for: .video, position: .front)
        guard
            let videoDeviceInput = try? AVCaptureDeviceInput(device: device!) as! AVCaptureInput,
            self.session!.canAddInput(videoDeviceInput)
        else { return false }
        self.session!.addInput(videoDeviceInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        let soundOutput = AVCaptureAudioDataOutput()
        guard self.session!.canAddOutput(videoOutput) else { return false }
        guard self.session!.canAddOutput(soundOutput) else { return false }
        self.session!.sessionPreset = .hd1280x720
        self.session!.addOutput(videoOutput)
        self.session!.addOutput(soundOutput)
        self.session!.commitConfiguration()
        
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

