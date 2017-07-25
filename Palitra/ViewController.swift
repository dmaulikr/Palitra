//
//  ViewController.swift
//  Palitra
//
//  Created by Martin Velchevski on 24.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear() {
        
        if let window  = self.view.window {
            window.title = "Palitra"
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.styleMask.insert(NSWindow.StyleMask.unifiedTitleAndToolbar)
            window.styleMask.insert(NSWindow.StyleMask.titled)
            window.toolbar?.isVisible = true
            window.standardWindowButton(.miniaturizeButton)!.isHidden = true
            window.standardWindowButton(.zoomButton)!.isHidden = true
            window.standardWindowButton(.closeButton)!.isHidden = false
        }
        
        let palitraTitlebarControls: NSTitlebarAccessoryViewController = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PalitraTitlebarControls")) as! NSTitlebarAccessoryViewController
        
        palitraTitlebarControls.layoutAttribute = .left
        
        self.view.window?.addTitlebarAccessoryViewController(palitraTitlebarControls)
    
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}



