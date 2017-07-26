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
    
    override func awakeFromNib() {
        buttonSetup()
    }
    
//    override func mouseDown(with event: NSEvent) {
//        super.mouseDown(with: event)
//    }
//
//    override func mouseUp(with event: NSEvent) {
//        super.mouseUp(with: event)
//    }
    
    func buttonSetup() {
        self.wantsLayer = true
        self.isBordered = false
        self.title = ""
        drawButton()
    }
    
    func drawButton() {

        if let id = buttonIdentifier {
            switch id {
            case "newPalette":
                self.image = PalitraStyleKit.imageOfPalitraNewButton(imageSize: self.frame.size)
                self.alternateImage = PalitraStyleKit.imageOfPalitraNewButtonActive(imageSize: self.frame.size)
            case "randomize":
                self.image = PalitraStyleKit.imageOfPalitraRandomizeButton(imageSize: self.frame.size)
                self.alternateImage = PalitraStyleKit.imageOfPalitraRandomizeButtonActive(imageSize: self.frame.size)
            case "sketchSync":
                self.image = PalitraStyleKit.imageOfPalitraSketchSyncButton(imageSize: self.frame.size)
                self.alternateImage = PalitraStyleKit.imageOfPalitraSketchSyncButtonActive(imageSize: self.frame.size)
            default:
                Swift.print("Invalid or unset button identifier")
            }
        } else {
            self.image = PalitraStyleKit.imageOfPalitraButton(imageSize: self.frame.size)
        }
    } 
}
