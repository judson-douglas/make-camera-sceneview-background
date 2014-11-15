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

    @IBOutlet weak var sceneView: SCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //capture video input in a AVCaptureLayerVideoPreviewLayer and add it as a sublayer to a UIView's layer
        var captureSession = AVCaptureSession()
        var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill

        if let videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) {
            var err: NSError? = nil
            if let videoIn : AVCaptureDeviceInput = AVCaptureDeviceInput.deviceInputWithDevice(videoDevice, error: &err) as? AVCaptureDeviceInput {
                if(err == nil){
                    if (captureSession.canAddInput(videoIn as AVCaptureInput)){
                        captureSession.addInput(videoIn as AVCaptureDeviceInput)
                    }
                    else {
                        println("Failed add video input.")
                    }
                }
                else {
                    println("Failed to create video input.")
                }
            }
            else {
                println("Failed to create video capture device.")
            }
        }
     //   previewLayer.frame = self.sceneView.bounds
     //   self.view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
        
        
        //create a SceneView with backgroundColor = UIColor.clearColor() and add it as a subview of the UIView
      
      //  sceneView.frame = self.view.bounds
     //   sceneView.backgroundColor = UIColor.clearColor()
        previewLayer.frame = self.sceneView.bounds
      //  scene.background.contents
       
        
       
        let scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        let boxGeometry = SCNBox(width: 10.0, height: 10.0, length: 10.0, chamferRadius: 1.0)
        let boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
        scene.background.contents = previewLayer
        sceneView.scene = scene
      
        
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }


}

