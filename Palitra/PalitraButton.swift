//
//  PalitraButton.swift
//  Palitra
//
//  Created by Martin Velchevski on 24.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa

@IBDesignable class PalitraButton: NSButton {
    
    @IBInspectable var buttonIdentifier: String?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        buttonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buttonSetup()
    }
    
    override func mouseDown(with event: NSEvent) {
        
    }
    
    override func mouseUp(with event: NSEvent) {
        
    }
    
    func buttonSetup() {
        self.wantsLayer = true
        self.title = ""
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.frame = dirtyRect
        
        if let id = self.buttonIdentifier {
            switch id {
            case "newPalette":
                PalitraStyleKit.drawPalitraNewButton(frame: dirtyRect)
            case "randomize":
                PalitraStyleKit.drawPalitraRandomizeButton(frame: dirtyRect)
            case "sketchSync":
                PalitraStyleKit.drawPalitraSketchSyncButton(frame: dirtyRect)
            default:
                Swift.print("Invalid or unset button identifier")
            }
        } else {
            PalitraStyleKit.drawPalitraButton(frame: dirtyRect)
        }
    
    }
    
    
}
