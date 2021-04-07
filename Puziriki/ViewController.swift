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
    var gravities = [UIGravityBehavior]()
    var collision = UICollisionBehavior()
    
    
    @objc func changeGravityAngle(){
        gravities.forEach{
            $0.angle += CGFloat.random(in: -1...1)
            $0.magnitude = CGFloat.random(in: 0.01...0.02)
        }
    }
    
    @IBOutlet weak var bubbleView: UIView!
    
    @IBAction func clearButtonPressed() {
        //for item in gravity.items
        //{
        //   gravity.removeItem(item)
        //}
        bubbleView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    @objc func bubbleViewTapped(touch: UITapGestureRecognizer)
    {
        let touchPoint = touch.location(in: bubbleView)
        let bubble = UIViewBubble(coords: (touchPoint.x, touchPoint.y))
        self.bubbleView.addSubview(bubble)
        addGravity()
        gravities[gravities.count - 1].addItem(bubble)
        collision.addItem(bubble)

        
    }
    
    func addGravity(){
        let gravity = UIGravityBehavior()
        gravity.magnitude = CGFloat.random(in: 0.01...0.02)
        gravities.append(gravity)
        animator.addBehavior(gravity)
    }
    
    func UIViewBubble(coords:(x: CGFloat, y: CGFloat)) -> UIView{
        let randSize = CGFloat.random(in: bubbleView.bounds.maxX/8...bubbleView.bounds.maxX/3)
        let puzirik = UIView(frame: CGRect(x: coords.x, y: coords.y, width: randSize, height: randSize))
        puzirik.layer.cornerRadius = randSize/2
        puzirik.layer.borderWidth = 2
        return puzirik

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(bubbleViewTapped(touch:)))
        tap.numberOfTapsRequired = 1
        bubbleView.addGestureRecognizer(tap)
        animator = UIDynamicAnimator.init(referenceView: bubbleView)
        


        // gravity set

        // set boundaries
        collision.translatesReferenceBoundsIntoBoundary = true

        animator.addBehavior(collision)
        
        
        //timer set
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeGravityAngle), userInfo: nil, repeats: true)
    }

}

