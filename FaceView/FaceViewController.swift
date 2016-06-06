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
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(_:))
                ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseSaddness)
            )
            sadderSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            faceView.addGestureRecognizer(UIRotationGestureRecognizer(
                target: self, action: #selector(FaceViewController.changeBrows(_:))
                ))
            updateUI()
        }
    }
    
    @IBAction func toggleEyes(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            switch expression.eyes {
            case .Closed:
                expression.eyes = .Open
            case .Open:
                expression.eyes = .Closed
            default:
                break
            }
        }
    }
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    func increaseSaddness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    func changeBrows(recongizer: UIRotationGestureRecognizer) {
        switch recongizer.state {
        case .Changed, .Ended:
            if recongizer.rotation > CGFloat(M_PI/4) {
                expression.eyeBrows = expression.eyeBrows.moreRelaxedBrow()
                recongizer.rotation = 0.0
            } else if recongizer.rotation < -CGFloat(M_PI/4) {
                expression.eyeBrows = expression.eyeBrows.moreFurrowed()
                recongizer.rotation = 0.0
            }
        default:
            break
        }
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0,.Smirk:-0.5,.Neutral:0.0,.Grin:0.5,.Smile:1.0]
    private let eyebrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Normal:0.0,.Furrowed:-0.5]
    
    private func updateUI() {
        if faceView != nil {
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
    
}

