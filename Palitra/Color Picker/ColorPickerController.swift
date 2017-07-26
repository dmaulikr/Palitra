//
//  ColorPickerController.swift
//  macOSColorPicker
//
//  Created by Martin Velchevski on 16.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

// This code is adapted for use on macOS.
// Original iOS project by - https://github.com/MrMatthias
// Original Codebase - https://github.com/MrMatthias/SwiftColorPicker

import Cocoa

class ColorPickerController: NSObject {
    
    open var onColorChange:((_ color:NSColor, _ finished:Bool)->Void)? = nil
    
    // Hue Picker
    open var huePicker:HuePicker
    
    // Color Picker
    open var colorPicker:ColorPicker
    
    open var color:NSColor? {
        set(value) {
            colorPicker.color = value!
            huePicker.setHueFromColor(value!)
        }
        get {
            return colorPicker.color
        }
    }
    
    public init(svPickerView:ColorPicker, huePickerView:HuePicker) {
        self.huePicker = huePickerView
        self.colorPicker = svPickerView
        self.huePicker.setHueFromColor(colorPicker.color)
        
        super.init()
        
        self.colorPicker.onColorChange = {(color, finished) -> Void in
            self.huePicker.setHueFromColor(color)
            self.onColorChange?(color, finished)
        }
        
        self.huePicker.onHueChange = {(hue, finished) -> Void in
            self.colorPicker.h = CGFloat(hue)
            let color = self.colorPicker.color
            self.onColorChange?(color, finished)
        }
        
    }
    
}
