//
//  PalitraSegmentedControlCell.swift
//  Palitra
//
//  Created by Martin Velchevski on 25.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa

@IBDesignable open class PalitraSegmentedControlCell: NSImageView {

    open var segment: Int?
    open var clickHandler: ((_ activeSegment: Int) -> Void)?
    
    open override func mouseDown(with event: NSEvent) {
        if let id = segment, let handler = clickHandler {
            handler(id)
        }
    }
    
    open override var wantsDefaultClipping: Bool {
        return false
    }
    
    open override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
}
