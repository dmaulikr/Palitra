//
//  NewPaletteViewController.swift
//  Palitra
//
//  Created by Martin Velchevski on 26.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa
import DynamicColorMacOS

class NewPaletteViewController: NSViewController  {
    
    @IBOutlet weak var colorPickerView: ColorPicker!
    @IBOutlet weak var huePickerView: HuePicker!
    var pickerController:ColorPickerController?
    
    @IBOutlet weak var colorName: NSTextField!
    @IBOutlet weak var hexValueContainerView: NSView!
    @IBOutlet weak var hexValue: NSTextField!
    @IBOutlet weak var colorPreview: NSView!

    @IBOutlet weak var cancelButton: PalitraButton!
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(sender)
    }
    
    @IBOutlet weak var proceedButton: PalitraButton!
    @IBAction func proceedButtonPressed(_ sender: Any) {
        
    }
    
    @IBOutlet weak var alpha: PalitraPalettePreviewSwatch!
    @IBOutlet weak var beta: PalitraPalettePreviewSwatch!
    @IBOutlet weak var gamma: PalitraPalettePreviewSwatch!
    @IBOutlet weak var delta: PalitraPalettePreviewSwatch!
    
    
    let colorNamer = ColorNamer()
    
    @IBOutlet weak var separator: NSView!
    
    func randomColor() -> DynamicColor {
        let randomH = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomL = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomS = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return DynamicColor(calibratedHue: randomH, saturation: randomS, brightness: randomL, alpha: 1)
    }
    
    func window(_ window: NSWindow, willPositionSheet sheet: NSWindow, using rect: NSRect) -> NSRect {
        Swift.print(window, sheet, rect)
        return NSMakeRect(0, 0, 200, 200)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CGColor.white
        self.view.layer?.cornerRadius = 4.0
        
        let initialColor: NSColor = randomColor()
        
        pickerController = ColorPickerController(svPickerView: colorPickerView!, huePickerView: huePickerView!)
        pickerController?.color = initialColor
        hexValue.stringValue = initialColor.toHexString()
        colorName.stringValue = colorNamer.name(initialColor.toHexString())
        
        hexValueContainerView.layer?.borderColor = PalitraStyleKit.lightGrey.cgColor
        hexValueContainerView.layer?.borderWidth = 1.0
        hexValueContainerView.layer?.cornerRadius = 4.0
        
        colorPreview.wantsLayer = true
        colorPreview.layer?.cornerRadius = 4.0
        colorPreview.layer?.backgroundColor = initialColor.cgColor
        
        separator.layer?.backgroundColor = PalitraStyleKit.lightGrey.cgColor
        
        alpha.color = initialColor
        beta.color = initialColor
        gamma.color = initialColor
        delta.color = initialColor

        pickerController?.onColorChange = {(color, finished) in
            self.colorPreview.layer?.backgroundColor = color.cgColor
            self.hexValue.stringValue = color.toHexString()
            self.colorName.stringValue = self.colorNamer.name(color.toHexString())
            self.alpha.color = color
            self.beta.color = color
            self.gamma.color = color
            self.delta.color = color
        }
    }
    
}
