//
//  ViewController.swift
//  FaceView
//
//  Created by Noah Patterson on 5/18/16.
//  Copyright © 2016 Noah Patterson. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView!
    private func updateUI() {
        switch expression.eyes {
        case .Open:      faceView.eyesOpen = true
        case .Closed:    faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        
        
        
    }
}

