//
//  ViewController.swift
//  JPAntMarchAnimation
//
//  Created by Jay Patel on 01/04/21.
//  Copyright © 2021 Jay Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var vwAntMarch: UIView!
    @IBOutlet weak var vwRoundAntMarch: UIView!
    @IBOutlet weak var sliderSpeed: UISlider!
    @IBOutlet weak var sliderBorder: UISlider!
    
    //MARK:- Custom Variables
    var lineWidth:CGFloat = 1.0
    var speed:CGFloat = 1.0

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupAntMarch()
    }
    
    //MARK:- Custom Functions
    func SetupAntMarch() {
        //Rectangle Ant March
        let shapeLayer = CAShapeLayer()
        let shapeRect = CGRect(x: 0.0, y: 0.0, width: 250.0, height: 250.0)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: 125.0, y: 125.0)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [NSNumber(value: 10), NSNumber(value: 10)]
        
        // Setup the path
        let path = CGMutablePath()
        path.addRect(shapeRect, transform: .identity)
        shapeLayer.path = path
        
        //Add Gradient
        let gradient1 = CAGradientLayer()
        gradient1.frame =  CGRect(origin: CGPoint.zero, size: self.vwAntMarch.frame.size)
        gradient1.colors = [UIColor.magenta.cgColor, UIColor.cyan.cgColor]
        gradient1.mask = shapeLayer
        
        self.vwAntMarch.layer.addSublayer(gradient1)
        
        if shapeLayer.animation(forKey: "linePhase") != nil {
            shapeLayer.removeAnimation(forKey: "linePhase")
        } else {
            var dashAnimation: CABasicAnimation?
            dashAnimation = CABasicAnimation(
                keyPath: "lineDashPhase")
            
            dashAnimation?.fromValue = NSNumber(value: 15.0)
            dashAnimation?.toValue = NSNumber(value: 0.0)
            dashAnimation?.duration = CFTimeInterval(speed)
            dashAnimation?.repeatCount = 10000
            
            shapeLayer.add(dashAnimation!, forKey: "linePhase")
        }
        
        
        
        //Circle Ant March
        let border = CAShapeLayer()
        border.path = UIBezierPath(roundedRect:self.vwRoundAntMarch.bounds, cornerRadius:125.0).cgPath
        border.frame = self.vwRoundAntMarch.bounds
        border.fillColor = nil
        border.strokeColor = UIColor.purple.cgColor
        border.lineWidth = lineWidth
        border.lineDashPattern = [15.0]
        
        self.vwRoundAntMarch.layer.addSublayer(border)
        
        if border.animation(forKey: "linePhase") != nil {
            border.removeAnimation(forKey: "linePhase")
        } else {
            var dashAnimation: CABasicAnimation?
            dashAnimation = CABasicAnimation(
                keyPath: "lineDashPhase")
            
            dashAnimation?.fromValue = NSNumber(value: 30.0)
            dashAnimation?.toValue = NSNumber(value: 0.0)
            dashAnimation?.duration = CFTimeInterval(speed)
            dashAnimation?.repeatCount = 10000
            
            border.add(dashAnimation!, forKey: "linePhase")
        }
    }
    
    //MARK:- IBActions
    @IBAction func sliderChangeValue(_ sender: UISlider) {
        if sender.tag == 1 {
            speed = CGFloat(self.sliderSpeed.value)
        } else {
            lineWidth = CGFloat(self.sliderBorder.value)
        }
        self.vwRoundAntMarch.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.vwAntMarch.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.SetupAntMarch()
    }
}

