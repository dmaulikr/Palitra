//
//  PalitraSectionHeader.swift
//  Palitra
//
//  Created by Martin Velchevski on 26.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa

@IBDesignable class PalitraSectionHeader: NSView {

    @IBInspectable var sectionHeaderPosition: String?
    
    func drawView(_ frame: NSRect) {
        if let pos = sectionHeaderPosition {
            switch pos {
            case "top":
                PalitraStyleKit.drawSectionViewWithTopSeparator(frame: frame)
            case "bottom":
                PalitraStyleKit.drawSectionViewWithBottomSeparator(frame: frame)
            default:
                Swift.print("invalid sectionHeaderPosition")
            }
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        drawView(dirtyRect)
    }
    
}
