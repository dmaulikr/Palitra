//
//  PalitraTitlebarControls.swift
//  Palitra
//
//  Created by Martin Velchevski on 24.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa

class PalitraTitlebarControls: NSTitlebarAccessoryViewController {

    @IBAction func newPaletteButtonClicked(_ sender: Any) {
        Swift.print("newPalette")
    }
    
    @IBAction func randomizeButtonClicked(_ sender: Any) {
        Swift.print("randomize")
    }
    
    
    @IBAction func sketchSyncButtonClicked(_ sender: Any) {
        Swift.print("sketchSync")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func testFunc() {
        Swift.print("hello from button")
    }
}
