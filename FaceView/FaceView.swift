//
//  FaceView.swift
//  FaceView
//
//  Created by Noah Patterson on 5/18/16.
//  Copyright © 2016 Noah Patterson. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    private var scale: CGFloat = 0.90
    // bounds is this UIView's coordinates system. Frame is this view within the superviews system. just width is the super view
    // must make a computed variable becasuse bounds has not been intitialized yet
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    //constants in swift
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false
        )
        path.lineWidth = 5.0
        
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func getPathForEye(eye: Eye) -> UIBezierPath {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        return pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
    }
    
    private func getPathForMouth() -> UIBezierPath {
        
    }
    
    
    
    private func drawSkull() {
        let skull = pathForCircleCenteredAtPoint(skullCenter, withRadius: skullRadius)
        UIColor.blueColor().set() // set() sets both fill and stroke

        skull.stroke()
    }
    
    private func drawEyes() {
        UIColor.blueColor().set() // set() sets both fill and stroke
        getPathForEye(Eye.Left).stroke()
        getPathForEye(Eye.Right).stroke()
    }
    
    override func drawRect(rect: CGRect) {
        //Drawing code
        drawSkull()
        drawEyes()
    }
}
