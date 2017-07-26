//
//  NewPaletteViewController.swift
//  Palitra
//
//  Created by Martin Velchevski on 26.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa
import DynamicColorMacOS

class NewPaletteViewController: NSViewController {
    
    @IBOutlet weak var colorPickerView: ColorPicker!
    @IBOutlet weak var huePickerView: HuePicker!
    var pickerController:ColorPickerController?
    
    @IBOutlet weak var colorName: NSTextField!
    @IBOutlet weak var hexValueContainerView: NSView!
    @IBOutlet weak var hexValue: NSTextField!
    @IBOutlet weak var colorPreview: NSView!
    
    func randomColor() -> DynamicColor {
        let randomH = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomL = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomS = CGFloat(arc4random()) / CGFloat(UInt32.max)
        Swift.print(randomH, randomS, randomL)
        return DynamicColor(calibratedHue: randomH, saturation: randomS, brightness: randomL, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CGColor.white
        self.view.layer?.cornerRadius = 4.0
        
        hexValueContainerView.layer?.borderColor = PalitraStyleKit.lightGrey.cgColor
        hexValueContainerView.layer?.borderWidth = 1.0
        hexValueContainerView.layer?.cornerRadius = 4.0
        
        pickerController = ColorPickerController(svPickerView: colorPickerView!, huePickerView: huePickerView!)
        pickerController?.color = randomColor()
        hexValue.stringValue = (pickerController?.color?.toHexString())!

        pickerController?.onColorChange = {(color, finished) in
            self.colorPreview.wantsLayer = true
            self.colorPreview.layer?.cornerRadius = 4.0
            self.colorPreview.layer?.backgroundColor = color.cgColor
            self.hexValue.stringValue = color.toHexString()
            self.randomColor()
        }
    }
    
}
