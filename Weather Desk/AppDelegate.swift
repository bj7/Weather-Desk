//
//  AppDelegate.swift
//  Weather Desk
//
//  Created by Joshua Bernitt on 1/1/17.
//  Copyright © 2017 Joshua Bernitt. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem = NSStatusBar.system().statusItem(withLength: -1)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        statusItem.title = "--°";
//        statusItem.image = NSImage(named: "Image");
//        let button = statusItem.button
//        button!.image = NSImage(named: "Image")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

