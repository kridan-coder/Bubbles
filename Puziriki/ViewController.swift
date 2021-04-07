//
//  ViewController.swift
//  Puziriki
//
//  Created by Daniil Zavodchanovich on 04.04.2021.
//

import UIKit


class Bubble{
    
}

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    var gravity = UIGravityBehavior()
    var collision = UICollisionBehavior()
    
    @IBOutlet weak var bubbleView: UIView!
    
    @IBAction func clearButtonPressed() {
    }
    
    @objc func bubbleViewTapped(touch: UITapGestureRecognizer)
    {
        let touchPoint = touch.location(in: bubbleView)
        let bubble = createBubble(coords: (touchPoint.x, touchPoint.y))
        self.view.addSubview(bubble)
        gravity.addItem(bubble)
        collision.addItem(bubble)

        
    }
    
    func createBubble(coords:(x: CGFloat, y: CGFloat)) -> UIView{
        let puzirik = UIView(frame: CGRect(x: coords.x, y: coords.y, width: 100, height: 100))
        puzirik.layer.cornerRadius = 25
        puzirik.layer.borderWidth = 2
        return puzirik

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(bubbleViewTapped(touch:)))
        tap.numberOfTapsRequired = 1
        bubbleView.addGestureRecognizer(tap)
        animator = UIDynamicAnimator.init(referenceView: self.view)
        // set boundaries
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
    }

}

