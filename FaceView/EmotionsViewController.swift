//
//  EmotionsViewController.swift
//  FaceView
//
//  Created by Noah Patterson on 6/4/16.
//  Copyright © 2016 Noah Patterson. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "show angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "show happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "show worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "show mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin),
    ]
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        let destinationvc = segue.destinationViewController
        if let facevc = destinationvc as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    facevc.expression = expression
                }
            }
        }

        // Pass the selected object to the new view controller.
    }
 

}
