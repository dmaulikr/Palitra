//
//  PalitraSegmentedControl.swift
//  Palitra
//
//  Created by Martin Velchevski on 25.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa

@IBDesignable class PalitraSegmentedControl: NSView {

    @IBOutlet var view: NSView!
    @IBOutlet weak var stackView: NSStackView!
    
    @IBOutlet weak var paletteModeSegment: PalitraSegmentedControlCell!
    @IBOutlet weak var specsModeSegment: PalitraSegmentedControlCell!
    @IBOutlet weak var libraryModeSegment: PalitraSegmentedControlCell!

    enum Mode: String {
        case Palette
        case Specs
        case Library
    }
    
    var currentState: Mode = .Palette
    var currentlyActiveSegment: Int = 0 {
        didSet {
            switch currentlyActiveSegment {
            case 0:
                currentState = .Palette
            case 1:
                currentState = .Specs
            case 2:
                currentState = .Library
            default:
                currentState = .Palette
            }
            setupSegments()
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        Bundle.main.loadNibNamed(NSNib.Name.init(rawValue: "PalitraSegmentedControl"), owner: self, topLevelObjects: nil)
        self.view.frame = self.bounds
        self.addSubview(self.view)
        self.wantsLayer = true
        stackView.layer?.cornerRadius = 4.0
        stackView.layer?.masksToBounds = true
        setupSegments()
        
    }
    
    //TODO: Make sure this gets cleaned up
    func setupSegments() {
        
        paletteModeSegment.segment = 0
        if (currentlyActiveSegment == paletteModeSegment.segment) {
            paletteModeSegment.image = PalitraStyleKit.imageOfPaletteModeSegmentActive()
            paletteModeSegment.layer?.backgroundColor = NSColor.black.cgColor
        } else {
            paletteModeSegment.image = PalitraStyleKit.imageOfPaletteModeSegmentInactive()
            paletteModeSegment.layer?.backgroundColor = NSColor.clear.cgColor
        }
        paletteModeSegment.clickHandler = { (n) -> Void in
            self.switchMode(activeSegment: n)
        }
        
        specsModeSegment.segment = 1
        if (currentlyActiveSegment == specsModeSegment.segment) {
            specsModeSegment.image = PalitraStyleKit.imageOfSpecsModeSegmentActive()
            specsModeSegment.layer?.backgroundColor = NSColor.black.cgColor
        } else {
            specsModeSegment.image = PalitraStyleKit.imageOfSpecsModeSegmentInactive()
            specsModeSegment.layer?.backgroundColor = NSColor.clear.cgColor
        }
        specsModeSegment.clickHandler = { (n) -> Void in
            self.switchMode(activeSegment: n)
        }
        
        libraryModeSegment.segment = 2
        if (currentlyActiveSegment == libraryModeSegment.segment) {
            libraryModeSegment.image = PalitraStyleKit.imageOfLibraryModeSegmentActive()
            libraryModeSegment.layer?.backgroundColor = NSColor.black.cgColor
        } else {
            libraryModeSegment.image = PalitraStyleKit.imageOfLibraryModeSegmentInactive()
            libraryModeSegment.layer?.backgroundColor = NSColor.clear.cgColor
        }
        libraryModeSegment.clickHandler = { (n) -> Void in
            self.switchMode(activeSegment: n)
        }
    }
    
    func switchMode(activeSegment: Int) {
        currentlyActiveSegment = activeSegment
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        PalitraStyleKit.drawPalitraButton(frame: dirtyRect)
    }
    
    override var wantsDefaultClipping: Bool {
        return false
    }
    
}
