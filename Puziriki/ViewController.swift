//
//  ViewController.swift
//  Puziriki
//
//  Created by Daniil Zavodchanovich on 04.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravities = [UIGravityBehavior]()
    var collision = UICollisionBehavior()
    
    
    @objc func changeGravityAngle(){
        guard !gravities.isEmpty else {return}
        gravities.randomElement()!.angle += CGFloat.random(in: -3.14...3.14)
        gravities.randomElement()!.magnitude = CGFloat.random(in: 0.01...0.03)
        
    }
    
    @IBOutlet weak var bubbleView: UIView!
    
    @IBAction func clearButtonPressed() {
        
        gravities.forEach{
            collision.removeItem($0.items.first!)
            $0.removeItem($0.items.first!)
            animator.removeBehavior($0)
        }
        bubbleView.subviews.forEach {
            $0.removeFromSuperview()
        }
        gravities.removeAll()
        
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
        let randSize = CGFloat.random(in: bubbleView.bounds.maxX/6...bubbleView.bounds.maxX/3)
        let puzirik = UIImageView(frame: CGRect(x: coords.x - randSize/2, y: coords.y - randSize/2, width: randSize, height: randSize))
        puzirik.layer.cornerRadius = randSize/2
        
        let image = UIImage(named: "ImageBubble")
        puzirik.image = image
        
        return puzirik
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bubbleViewTapped(touch:)))
        
        tap.numberOfTapsRequired = 1
        
        bubbleView.addGestureRecognizer(tap)
        
        animator = UIDynamicAnimator.init(referenceView: bubbleView)
        
        // set boundaries
        collision.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(collision)
        
        
        //timer set
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeGravityAngle), userInfo: nil, repeats: true)
    }
    
}

