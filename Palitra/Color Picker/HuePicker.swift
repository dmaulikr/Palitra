//
//  HuePicker.swift
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

open class HuePicker: NSView {
    
    var _h:CGFloat = 0.1111
    open var h:CGFloat { // [0,1]
        set(value) {
            _h = min(1, max(0, value))
            currentPoint = CGPoint(x: bounds.width * CGFloat(_h), y: 0)
            handleRect = CGRect(x: currentPoint.x-3, y: 0, width: 6, height: bounds.height)
            setNeedsDisplay(self.bounds)
        }
        get {
            return _h
        }
    }
    var image:NSImage?
    fileprivate var data:[UInt8]?
    fileprivate var currentPoint = CGPoint.zero
    fileprivate var handleRect = CGRect.zero
    open var handleColor:NSColor = NSColor.black
    
    open var onHueChange:((_ hue:CGFloat, _ finished:Bool) -> Void)?
    
    open func setHueFromColor(_ color:NSColor) {
        var h:CGFloat = 0
        color.getHue(&h, saturation: nil, brightness: nil, alpha: nil)
        self.h = h
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func renderBitmap() {
        if bounds.isEmpty {
            return
        }
        
        let width = UInt(bounds.width)
        let height = UInt(bounds.height)
        
        if  data == nil {
            data = [UInt8](repeating: UInt8(255), count: Int(width * height) * 4)
        }
        
        var p = 0.0
        var q = 0.0
        var t = 0.0
        
        var i = 0
        //_ = 255
        var double_v:Double = 0
        var double_s:Double = 0
        let widthRatio:Double = 360 / Double(bounds.width)
        var d = data!
        for hi in 0..<Int(bounds.width) {
            let double_h:Double = widthRatio * Double(hi) / 60
            let sector:Int = Int(floor(double_h))
            let f:Double = double_h - Double(sector)
            let f1:Double = 1.0 - f
            double_v = Double(1)
            double_s = Double(1)
            p = double_v * (1.0 - double_s) * 255
            q = double_v * (1.0 - double_s * f) * 255
            t = double_v * ( 1.0 - double_s  * f1) * 255
            let v255 = double_v * 255
            i = hi * 4
            switch(sector) {
            case 0:
                d[i+1] = UInt8(v255)
                d[i+2] = UInt8(t)
                d[i+3] = UInt8(p)
            case 1:
                d[i+1] = UInt8(q)
                d[i+2] = UInt8(v255)
                d[i+3] = UInt8(p)
            case 2:
                d[i+1] = UInt8(p)
                d[i+2] = UInt8(v255)
                d[i+3] = UInt8(t)
            case 3:
                d[i+1] = UInt8(p)
                d[i+2] = UInt8(q)
                d[i+3] = UInt8(v255)
            case 4:
                d[i+1] = UInt8(t)
                d[i+2] = UInt8(p)
                d[i+3] = UInt8(v255)
            default:
                d[i+1] = UInt8(v255)
                d[i+2] = UInt8(p)
                d[i+3] = UInt8(q)
            }
        }
        var sourcei = 0
        for v in 1..<Int(bounds.height) {
            for s in 0..<Int(bounds.width) {
                sourcei = s * 4
                i = (v * Int(width) * 4) + sourcei
                d[i+1] = d[sourcei+1]
                d[i+2] = d[sourcei+2]
                d[i+3] = d[sourcei+3]
            }
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        let provider = CGDataProvider(data: Data(bytes: d, count: d.count * MemoryLayout<UInt8>.size) as CFData)
        let cgimg = CGImage(width: Int(width), height: Int(height), bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: Int(width) * Int(MemoryLayout<UInt8>.size * 4),
                            space: colorSpace, bitmapInfo: bitmapInfo, provider: provider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
        
        
        image = NSImage(cgImage: cgimg!, size: self.bounds.size)
        
    }
    
    open override func mouseDown(with event: NSEvent) {
        let p: NSPoint = event.locationInWindow
        let center = self.convert(p, from: nil)
        handleMouseEvent(center, ended: false)
    }
    
    open override func mouseDragged(with event: NSEvent) {
        let p: NSPoint = event.locationInWindow
        let center = self.convert(p, from: nil)
        handleMouseEvent(center, ended: false)
    }
    
    open override func mouseUp(with event: NSEvent) {
        let p: NSPoint = event.locationInWindow
        let center = self.convert(p, from: nil)
        handleMouseEvent(center, ended: true)
    }
    
    fileprivate func handleMouseEvent(_ point: CGPoint, ended: Bool) {
        currentPoint = CGPoint(x: max(0, min(bounds.width, point.x)) , y: 0)
        handleRect = CGRect(x: currentPoint.x-3, y: 0, width: 6, height: bounds.height)
        _h = (1/bounds.width) * currentPoint.x
        onHueChange?(h, ended)
        self.setNeedsDisplay(self.bounds)
    }
    
    open override var wantsDefaultClipping: Bool {
        return true
    }
    
//    open override var alignmentRectInsets: NSEdgeInsets {
//        return NSEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
//    }
    
    override open func draw(_ rect: CGRect) {
        self.wantsLayer = true
        self.layer?.cornerRadius = 4.0
        if image == nil {
            renderBitmap()
        }
        if let img = image {
            img.draw(in: rect)
        }
        
        drawHueDragHandler(frame: handleRect)
    }
    
    func drawHueDragHandler(frame: CGRect) {

        
        PalitraStyleKit.drawHueSelector(frame: NSMakeRect(frame.midX - 3, 0, 6, 12), resizing: PalitraStyleKit.ResizingBehavior.center)
        
        
//        //// Polygon Drawing
//        let polygonPath = NSBezierPath()
//        polygonPath.move(to: CGPoint(x: frame.minX + 4, y: frame.maxY - 6))
//        polygonPath.line(to: CGPoint(x: frame.minX + 7.46, y: frame.maxY))
//        polygonPath.line(to: CGPoint(x: frame.minX + 0.54, y: frame.maxY))
//        polygonPath.close()
//        NSColor.black.setFill()
//        polygonPath.fill()
//
//
//        //// Polygon 2 Drawing
//        let polygon2Path = NSBezierPath()
//        polygon2Path.move(to: CGPoint(x: frame.minX + 4, y: frame.minY + 6))
//        polygon2Path.line(to: CGPoint(x: frame.minX + 7.46, y: frame.minY))
//        polygon2Path.line(to: CGPoint(x: frame.minX + 0.54, y: frame.minY))
//        polygon2Path.close()
//        NSColor.white.setFill()
//        polygon2Path.fill()
    }
    
    
    
    
}
