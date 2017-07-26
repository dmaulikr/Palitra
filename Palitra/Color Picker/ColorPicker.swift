//
//  ColorPicker.swift
//  macOSColorPicker
//
//  Created by Martin Velchevski on 16.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

// This code is adapted for use on macOS.
// Original iOS project by - https://github.com/MrMatthias
// Original Codebase - https://github.com/MrMatthias/SwiftColorPicker

import Foundation
import Cocoa
import ImageIO

open class ColorPicker: NSView {
    
    fileprivate var pickerImage1:PickerImage?
    fileprivate var pickerImage2:PickerImage?
    fileprivate var image:NSImage?
    fileprivate var data1Shown:Bool = false
    fileprivate lazy var opQueue:OperationQueue = {return OperationQueue()}()
    fileprivate var lock:NSLock = NSLock()
    fileprivate var rerender:Bool = false
    open var onColorChange:((_ color:NSColor, _ finished:Bool)->Void)? = nil
    
    
    open var a:CGFloat = 1 {
        didSet {
            if a < 0 || a > 1 {
                a = max(0, min(1, a))
            }
        }
    }
    
    open var h:CGFloat = 0 { // // [0,1]
        didSet {
            if h > 1 || h < 0 {
                h = max(0, min(1, h))
            }
            renderBitmap()
            setNeedsDisplay(self.bounds)
        }
    }
    
    fileprivate var currentPoint:CGPoint = CGPoint.zero
    
    open func saturationFromCurrentPoint() -> CGFloat {
        return (1 / bounds.width) * currentPoint.x
    }
    
    open func brigthnessFromCurrentPoint() -> CGFloat {
        return (1 / bounds.height) * currentPoint.y
    }
    
    open var color:NSColor  {
        set(value) {
            var hue:CGFloat = 1
            var saturation:CGFloat = 1
            var brightness:CGFloat = 1
            var alpha:CGFloat = 1
            value.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            a = alpha
            if hue != h || pickerImage1 === nil {
                self.h = hue
            }
            currentPoint = CGPoint(x: saturation * bounds.width, y: brightness * bounds.height)
            self.setNeedsDisplay(self.bounds)
        }
        get {
            return NSColor(hue: h, saturation: saturationFromCurrentPoint(), brightness: brigthnessFromCurrentPoint(), alpha: a)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.addObserver(self, forKeyPath: "bounds", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.initial], context: nil)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "bounds")
    }
    
    open override var wantsDefaultClipping: Bool {
        return false
    }
    
    open override var isFlipped: Bool {
        return true
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds" {
            if let pImage1 = pickerImage1 {
                pImage1.changeSize(Int(self.bounds.width), height: Int(self.bounds.height))
            }
            if let pImage2 = pickerImage2 {
                pImage2.changeSize(Int(self.bounds.width), height: Int(self.bounds.height))
            }
            renderBitmap()
            self.setNeedsDisplay(self.bounds)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    

    open override func mouseDown(with event: NSEvent) {
        let p: NSPoint = event.locationInWindow
        let center = self.convert(p, from: nil)
        handleTouch(center, ended: false)
    }
    
    open override func mouseDragged(with event: NSEvent) {
        let p: NSPoint = event.locationInWindow
        let center = self.convert(p, from: nil)
        handleTouch(center, ended: false)
    }
    
    open override func mouseUp(with event: NSEvent) {
        let p: NSPoint = event.locationInWindow
        let center = self.convert(p, from: nil)
        handleTouch(center, ended: true)
    }
    
    // TODO: Fix bug where dragging handle to the outer edges causes hue to behave weirdly
    // because of point from outside the bounds is being passed
    fileprivate func handleTouch(_ point:CGPoint, ended:Bool) {
        if self.bounds.contains(point) {
            currentPoint = point
        } else {
            let x:CGFloat = min(bounds.width, max(0, point.x))
            let y:CGFloat = min(bounds.height, max(0, point.y))
            currentPoint = CGPoint(x: x, y: y)
        }
        handleColorChange(pointToColor(point), changing: !ended)
    }
    
    fileprivate func handleColorChange(_ color:NSColor, changing:Bool) {
        if color !== self.color {
            if let handler = onColorChange {
                handler(color, !changing)
            }
            self.setNeedsDisplay(self.bounds)
        }
    }
 
    fileprivate func pointToColor(_ point:CGPoint) -> NSColor {
        let s:CGFloat = min(1, max(0, (1.0 / bounds.width) * point.x))
        let b:CGFloat = min(1, max(0, (1.0 / bounds.height) * point.y))
        return NSColor(hue: h, saturation: s, brightness: b, alpha:a)
    }
    
    fileprivate func renderBitmap() {
        
        self.pickerImage1 = PickerImage(width: Int(bounds.width), height: Int(bounds.height))
        self.pickerImage1!.writeColorData(self.h, a:self.a)
        self.image = self.pickerImage1?.image
        self.setNeedsDisplay(self.bounds)
        
    }
    
    open override func draw(_ rect: CGRect) {
        if let img = image {
            img.draw(in: rect)
        }
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 4.0
        
        PalitraStyleKit.drawColorPickerCrosshair(frame: NSMakeRect(0, 0, 13, 13), resizing: PalitraStyleKit.ResizingBehavior.center, crossHairPosition: NSPoint(x: currentPoint.x - 6, y: currentPoint.y - 6))
    }
}

