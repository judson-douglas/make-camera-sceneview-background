//
//  ViewController.swift
//  DrawsCameraAsBackgoundWithSceneKit
//
//  Created by Judson Douglas on 11/14/14.
//  Copyright (c) 2014 Judson Douglas. All rights reserved.
//

import UIKit
import SceneKit
import AVFoundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //capture video input in an AVCaptureLayerVideoPreviewLayer
        let captureSession = AVCaptureSession()
        
        guard let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) else {
            print("Failed to create video capture preview")
            return
        }
        
        guard let videoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else {
            print("Failed to create video capture device.")
            return
        }

        guard let videoIn = try? AVCaptureDeviceInput(device: videoDevice) else {
            print("Failed to create video input")
            return
        }
        
        guard captureSession.canAddInput(videoIn as AVCaptureInput) else {
            print("Failed add video input.")
            return
        }
        
        captureSession.addInput(videoIn as AVCaptureDeviceInput)
        captureSession.startRunning()
        
        //add AVCaptureVideoPreviewLayer as sublayer of self.view.layer
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer)
        
        //create a SceneView with a clear background color and add it as a subview of self.view
        let sceneView = SCNView()
        sceneView.frame = self.view.bounds
        sceneView.backgroundColor = .clear
        previewLayer.frame = self.view.bounds
        self.view.addSubview(sceneView)
        
        //now you could begin to build your scene with the device's camera video as your background
        let scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        let boxGeometry = SCNBox(width: 10.0, height: 10.0, length: 10.0, chamferRadius: 1.0)
        let boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
        sceneView.scene = scene
        
    }
}


