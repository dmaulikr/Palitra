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
    @IBInspectable var buttonTitle: String?
    @IBInspectable var isPrimary: Bool = false
    
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
    
    func buttonSetup() {
        self.wantsLayer = true
        self.isBordered = false
        drawButton()
    }
    
    func drawButton() {
        
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .center
        
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
            case "labeled":
                switch isPrimary {
                case true:
                    self.image = PalitraStyleKit.imageOfPalitraButtonDark(imageSize: self.frame.size)
                    self.attributedTitle = NSAttributedString(string: buttonTitle!, attributes: [NSAttributedStringKey.foregroundColor : NSColor.white, NSAttributedStringKey.paragraphStyle : pstyle])
                case false:
                    self.image = PalitraStyleKit.imageOfPalitraButton(imageSize: self.frame.size)
                                        self.attributedTitle = NSAttributedString(string: buttonTitle!, attributes: [NSAttributedStringKey.foregroundColor : NSColor.black, NSAttributedStringKey.paragraphStyle : pstyle])
                }
            default:
                Swift.print("Invalid or unset button identifier")
            }
        }
    } 
}
