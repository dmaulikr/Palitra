//
//  PalitraPalettePreviewSwatch.swift
//  Palitra
//
//  Created by Martin Velchevski on 27.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa

class PalitraPalettePreviewSwatch: NSView {
    
    @IBInspectable var swatchType: String?
    var color: NSColor? {
        didSet {
            setNeedsDisplay(self.bounds)
        }
    }
    
    let swatchShapes = PalitraPalettePreviewSwatchShapes()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.wantsLayer = true
        self.layer?.cornerRadius = 4.0
        
        if let c = color, let type = swatchType {
            switch type {
            case "alpha":
                swatchShapes.drawAlphaSwatch(withColor: c, inFrame: dirtyRect)
            case "beta":
                Swift.print("beta")
            case "charlie":
                swatchShapes.drawCharlieSwatch(withColor: c, inFrame: dirtyRect)
            default:
                print("no such swatchType")
            }
        }
    }
}
