//
//  ColorNamer.swift
//  Palitra
//
//  Created by Martin Velchevski on 27.07.17.
//  Copyright © 2017 Martin Velchevski. All rights reserved.
//

import Cocoa
import JavaScriptCore

open class ColorNamer: NSObject {
    
    let jsContext = JSContext()
    
    override init() {
        super.init()
        initializeJS()
    }
    
    func initializeJS() {
        if let jsSourcePath = Bundle.main.path(forResource: "ColorNamer", ofType: "js") {
            do {
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                self.jsContext?.evaluateScript(jsSourceContents)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    open func name(_ color: String) -> String {
        let color = color
        var name:String = ""
        if let nameColor = self.jsContext?.objectForKeyedSubscript("ntc").forProperty("name") {
            if let colorName = nameColor.call(withArguments: [color]) {
                name = colorName.objectAtIndexedSubscript(1).toString()
            }
        }
        return name
    }
    
}
