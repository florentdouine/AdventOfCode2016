//
//  AppDelegate.swift
//  AdventOfCode
//
//  Created by Florent Douine on 28/08/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let puzzle = Puzzle1();
        puzzle.startResolution();
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

