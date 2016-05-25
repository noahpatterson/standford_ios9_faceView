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
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            updateUI()
        }
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0,.Smirk:-0.5,.Neutral:0.0,.Grin:0.5,.Smile:1.0]
    private let eyebrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Normal:0.0,.Furrowed:-0.5]
    
    private func updateUI() {
        switch expression.eyes {
        case .Open:      faceView.eyesOpen = true
        case .Closed:    faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        // default to 0.0 if the expression is not in the lookup
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyebrowTilts[expression.eyeBrows] ?? 0.0
        
        faceView.lineWidth = CGFloat(1.0)
    }
    
}

