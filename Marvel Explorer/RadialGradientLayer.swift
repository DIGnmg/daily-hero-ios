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
	
	var center:CGPoint = CGPoint(x: 244/2,y: 244/2)
	var radius:CGFloat = 20.0
	var colors:[CGColor] = [
		UIColor(red: 251/255, green: 237/255, blue:  33/255, alpha: 1.0).cgColor,
		UIColor(red: 251/255, green: 179/255, blue: 108/255, alpha: 1.0).cgColor
	]
	
	override func draw(in ctx: CGContext) {
		
		ctx.saveGState()
		
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let locations:[CGFloat] = [0.0, 1.0]
		let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
		
		//var startPoint = CGPointMake(0, self.bounds.height)
		//var endPoint = CGPointMake(self.bounds.width, self.bounds.height)
		
		ctx.drawRadialGradient(gradient!,
			startCenter: center, startRadius: 0.0,
			endCenter: center, endRadius: radius,
			options: CGGradientDrawingOptions.drawsAfterEndLocation
		)
		
		ctx.restoreGState()
		
	}
	
}
