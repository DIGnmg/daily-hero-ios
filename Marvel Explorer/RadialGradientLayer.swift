//
//  RadialGradientLayer.swift
//  Marvel Explorer
//
//  Created by Adam Reeves on 6/4/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class RadialGradientLayer: CALayer {
    
	override init(){
		super.init()
		
		needsDisplayOnBoundsChange = true
	}
	
	init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
        super.init()
        
		self.center = center
		self.radius = radius
		self.colors = colors
    
	}
	
	required init(coder aDecoder: NSCoder) {
		
		super.init()

	}
	
	var center:CGPoint = CGPointMake(244/2,244/2)
	var radius:CGFloat = 20.0
	var colors:[CGColor] = [
		UIColor(red: 251/255, green: 237/255, blue:  33/255, alpha: 1.0).CGColor,
		UIColor(red: 251/255, green: 179/255, blue: 108/255, alpha: 1.0).CGColor
	]
	
	override func drawInContext(ctx: CGContext) {
		
		CGContextSaveGState(ctx)
		
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let locations:[CGFloat] = [0.0, 1.0]
		let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
		
		//var startPoint = CGPointMake(0, self.bounds.height)
		//var endPoint = CGPointMake(self.bounds.width, self.bounds.height)
		
		CGContextDrawRadialGradient(
			ctx, gradient,
			center, 0.0,
			center, radius,
			CGGradientDrawingOptions.DrawsAfterEndLocation
		)
		
		CGContextRestoreGState(ctx)
		
	}
	
}
