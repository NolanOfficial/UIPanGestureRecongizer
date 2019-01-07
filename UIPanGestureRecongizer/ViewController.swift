//
//  ViewController.swift
//  UIPanGestureRecongizer
//
//  Created by Nolan Fuchs on 1/6/19.
//  Copyright © 2019 Nolan Fuchs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var file: UIImageView!
    @IBOutlet weak var trashCan: UIImageView!
    
    var fileViewOrigin: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPanGesture(view: file)
        fileViewOrigin = file.frame.origin
    }

    
    func addPanGesture(view: UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
        
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let fileView = sender.view
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            
            fileView?.center = CGPoint(x: (fileView?.center.x)! + translation.x, y: (fileView?.center.y)! + translation.y)
             sender.setTranslation(CGPoint.zero, in: view)
            
        case .ended:
            
            if fileView!.frame.intersects(trashCan.frame) {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.file.alpha = 0.0
                    })
                self.file.removeFromSuperview()
                
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.file.frame.origin = self.fileViewOrigin
                    })
            }
            
        default:
            break
        }
        
        
    }

}

