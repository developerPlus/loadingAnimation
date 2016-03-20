//
//  ViewController.swift
//  loadingImage
//
//  Created by Vampires on 16/3/17.
//  Copyright © 2016年 Vampires. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var circleLayer  : CAShapeLayer?
    var triangleLayer: CAShapeLayer?
    var cakeLayer    : CAShapeLayer?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bulidLayer()
        
        
    }
    
    func bulidLayer() {
        
        self.imageView.alpha = 0.46
        
        let start : CGFloat = -CGFloat(M_PI_2)
        let end : CGFloat  = CGFloat(M_PI + M_PI_2)
        let point = CGPointMake(CGRectGetWidth(imageView.frame) / 2, CGRectGetWidth(imageView.frame) / 2)
        let radius = CGRectGetWidth(imageView.frame) / 4
        
        //圆圈
        circleLayer = CAShapeLayer()
        circleLayer?.path = UIBezierPath(arcCenter: point, radius: radius, startAngle: start, endAngle: end, clockwise: true).CGPath
        circleLayer?.fillColor = nil;
        circleLayer?.strokeColor = UIColor.whiteColor().CGColor
        circleLayer?.lineWidth = 1.4
        circleLayer?.frame = imageView.bounds
        self.imageView.layer .addSublayer(circleLayer!)
        
        
        //三角形
        let trianglePath = UIBezierPath.init()
        trianglePath.moveToPoint(CGPointMake(point.x - (radius + 8) / 2 + 16, point.y + (radius + 8) / 2 - 8))
        trianglePath.addLineToPoint(CGPointMake(point.x - (radius + 8) / 2 + 16, point.y - (radius + 8) / 2 + 8)) ;
        trianglePath.addLineToPoint(CGPointMake(point.x + (radius + 8) / 2 , point.y));
        trianglePath.closePath()
        triangleLayer = CAShapeLayer()
        triangleLayer?.path = trianglePath.CGPath
        triangleLayer?.fillColor = nil
        triangleLayer?.strokeColor = UIColor.whiteColor().CGColor
        triangleLayer?.lineWidth = 1.9
        triangleLayer?.frame = imageView.bounds
        self.imageView.layer.addSublayer(triangleLayer!)
        
        //饼状图
        cakeLayer = CAShapeLayer()
        cakeLayer?.path = UIBezierPath(arcCenter: point, radius: radius / 2, startAngle: start, endAngle: end, clockwise: true).CGPath
        cakeLayer?.fillColor = nil
        cakeLayer?.strokeColor = UIColor.whiteColor().CGColor
        cakeLayer?.lineWidth = radius
        cakeLayer?.frame = imageView.bounds
        self.imageView.layer.addSublayer(cakeLayer!)
        
        cakeLayer?.hidden = true
        
        //添加手势
        let singleTap = UITapGestureRecognizer.init(target:self, action: "handleSingleTap:")
        singleTap.numberOfTapsRequired = 1
        
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(singleTap)
        
        
        
    }
    
    
    func handleSingleTap (tap : UITapGestureRecognizer) {
        
        cakeLayer?.hidden = false
        triangleLayer?.path = nil
        
        let start : CGFloat = 0.0
        let end : CGFloat  = CGFloat(M_PI + M_PI_2 + M_PI_4)
        let point = CGPointMake(CGRectGetWidth(imageView.frame) / 2, CGRectGetWidth(imageView.frame) / 2)
        let radius = CGRectGetWidth(imageView.frame) / 3
        
        circleLayer?.path = nil
        circleLayer?.path = UIBezierPath(arcCenter: point, radius: radius - 10, startAngle: start, endAngle: end, clockwise: true).CGPath
        
        let circleAnimation = CABasicAnimation.init(keyPath: "r")
        circleAnimation.fromValue = 0
        circleAnimation.toValue = M_PI * 2
        circleAnimation.duration = 3;
        circleAnimation.repeatCount = MAXFLOAT
        circleLayer?.addAnimation(circleAnimation, forKey: nil)
        
        let cakeAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        cakeAnimation.fromValue = 0
        cakeAnimation.toValue = 1
        cakeAnimation.duration = 8.0;
        cakeAnimation.delegate = self
        cakeLayer?.addAnimation(cakeAnimation, forKey: nil)
        
        
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        circleLayer?.path = nil
        cakeLayer?.path = nil
        self.imageView.alpha = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

