//
//  PalitraPalettePreviewSwatchShapes.swift
//  Palitra
//
//  Created by Martin Velchevski on 27.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa
import DynamicColorMacOS

open class PalitraPalettePreviewSwatchShapes: NSObject {
    
    open func drawCharlieSwatch(withColor color: NSColor, inFrame frame: NSRect ) {

        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }
        
        let c = color.toHSBComponents()
        
        let mainColor = DynamicColor(calibratedHue: c.h, saturation: c.s, brightness: c.b, alpha: 1)
        let mainTint = mainColor.lighter(amount: 0.4)
        let mainShade = mainColor.darkened(amount: 0.1)
        let secondary = mainColor.complemented()
        let secondaryTint = secondary.lighter(amount: 0.4)
        let secondaryShade = secondary.darkened(amount: 0.1)
        
        //// secondaryMain Drawing
        let secondaryMainPath = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.50000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.18605 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.50000 + 0.5), height: fastFloor(frame.height * 0.81395 + 0.5) - fastFloor(frame.height * 0.18605 + 0.5)))
        secondary.setFill()
        secondaryMainPath.fill()
        
        
        //// secondaryShade Drawing
        let secondaryShadePath = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.50000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.00000 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.50000 + 0.5), height: fastFloor(frame.height * 0.18605 + 0.5) - fastFloor(frame.height * 0.00000 + 0.5)))
        secondaryShade.setFill()
        secondaryShadePath.fill()
        
        
        //// main Drawing
        let mainPath = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.18605 + 0.5), width: fastFloor(frame.width * 0.50000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 0.81395 + 0.5) - fastFloor(frame.height * 0.18605 + 0.5)))
        mainColor.setFill()
        mainPath.fill()
        
        
        //// secondaryTint Drawing
        let secondaryTintPath = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.50000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.81395 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.50000 + 0.5), height: fastFloor(frame.height * 1.00000 + 0.5) - fastFloor(frame.height * 0.81395 + 0.5)))
        secondaryTint.setFill()
        secondaryTintPath.fill()
        
        
        //// mainTint Drawing
        let mainTintPath = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.81395 + 0.5), width: fastFloor(frame.width * 0.50000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 1.00000 + 0.5) - fastFloor(frame.height * 0.81395 + 0.5)))
        mainTint.setFill()
        mainTintPath.fill()
        
        
        //// mainShade Drawing
        let mainShadePath = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.00000 + 0.5), width: fastFloor(frame.width * 0.50000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 0.18605 + 0.5) - fastFloor(frame.height * 0.00000 + 0.5)))
        mainShade.setFill()
        mainShadePath.fill()
    }

    
    open func drawAlphaSwatch(withColor color: NSColor, inFrame frame: NSRect) {
        
        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }
        
        let c = color.toHSBComponents()
        
        let mainColor = DynamicColor(calibratedHue: c.h, saturation: c.s, brightness: c.b, alpha: 1)
        let tint1Color = mainColor.lighter(amount: 0.4)
        let tint2Color = mainColor.lighter(amount: 0.2)
        let shadeColor = mainColor.darkened(amount: 0.1)
        
        //// shade Drawing
        let shadePath = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.00000 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 0.18605 + 0.5) - fastFloor(frame.height * 0.00000 + 0.5)))
        shadeColor.setFill()
        shadePath.fill()
        
        
        //// main Drawing
        let mainPath = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.18605 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 0.62791 + 0.5) - fastFloor(frame.height * 0.18605 + 0.5)))
        mainColor.setFill()
        mainPath.fill()
        
        
        //// tint2 Drawing
        let tint2Path = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.62791 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 0.81395 + 0.5) - fastFloor(frame.height * 0.62791 + 0.5)))
        tint2Color.setFill()
        tint2Path.fill()
        
        
        //// tint1 Drawing
        let tint1Path = NSBezierPath(rect: NSRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.81395 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 1.00000 + 0.5) - fastFloor(frame.height * 0.81395 + 0.5)))
        tint1Color.setFill()
        tint1Path.fill()
        
    }



    
}
