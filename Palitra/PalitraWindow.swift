//
//  PalitraWindow.swift
//  Palitra
//
//  Created by Martin Velchevski on 24.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa

class PalitraWindow: NSWindow {
     
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        self.backgroundColor = NSColor.white
    }
    
}
