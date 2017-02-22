
//  Created by Devine Lu Linvega on 2015-12-18.
//  Copyright (c) 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreGame
{
	var time:Float = 0
	let memory = UserDefaults.standard
	
	init()
	{
		print("^ Game | Init")
		Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.onTic), userInfo: nil, repeats: true)
		Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.whenSecond), userInfo: nil, repeats: true)
	}
	
	func whenStart()
	{
		print("+ Game | Start")
		load(memory.integer(forKey: "state"))
	}
	
	func save(_ id:Int)
	{
		print("@ GAME     | Saved State to \(id)")
		memory.setValue(id, forKey: "state")
		memory.setValue(version, forKey: "version")
	}
	
	func load(_ id:Int)
	{
		let id = (id == 20) ? 0 : id
		
		print("@ GAME     | Loaded State to \(id)")
		
		for mission in missions.story {
			if mission.id < id {
				mission.complete()
			}
		}
		missions.story[id].state()
	}
	
	func state() -> Int
	{
		return memory.integer(forKey: "state")
	}
	
	func erase()
	{
		print("$ GAME     | Erase")
		
		let appDomain = Bundle.main.bundleIdentifier!
		UserDefaults.standard.removePersistentDomain(forName: appDomain)
	}
	
    var needsSecond = false
    var needsTic = false
    
	@objc func whenSecond()
	{
        self.needsSecond = true
	}
	
	@objc func onTic()
	{
        self.needsTic = true
	}
    
    func doSecond()
    {
        if self.needsSecond == true
        {
            self.needsSecond = false
            capsule.whenSecond()
            missions.refresh()
        }
    }
    
    func doTic()
    {
        if self.needsTic == true
        {
            self.needsTic = false
            self.time += 1
            space.whenTime()
        }
    }
}
