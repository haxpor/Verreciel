
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelBattery : MainPanel
{
	var cellPort1:SCNPortSlot!
	var cellPort2:SCNPortSlot!
	var cellPort3:SCNPortSlot!
	
	var enigmaLabel:SCNLabel!
	var thrusterLabel:SCNLabel!
	var radioLabel:SCNLabel!
	var mapLabel:SCNLabel!
	var shieldLabel:SCNLabel!
	
	var enigmaPort:SCNPort!
	var thrusterPort:SCNPort!
	var radioPort:SCNPort!
	var mapPort:SCNPort!
	var shieldPort:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "battery"
		
		// Decals
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
		// Cells
		
		let distance:Float = 0.4
		
		cellPort1 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align:.right)
		cellPort1.position = SCNVector3(x: -distance, y: templates.lineSpacing, z: 0)
		cellPort1.enable()
		mainNode.addChildNode(cellPort1)
		
		cellPort2 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align:.right)
		cellPort2.position = SCNVector3(x: -distance, y: 0, z: 0)
		cellPort2.enable()
		mainNode.addChildNode(cellPort2)
		
		cellPort3 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align:.right)
		cellPort3.position = SCNVector3(x: -distance, y: -templates.lineSpacing, z: 0)
		cellPort3.enable()
		mainNode.addChildNode(cellPort3)
		
		// Systems
		
		enigmaPort = SCNPort(host: self, input:Item.self)
		enigmaPort.position = SCNVector3(x: distance, y: -templates.lineSpacing, z: 0)
		enigmaLabel = SCNLabel(text: "shield", scale: 0.1, align: alignment.left)
		enigmaLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		enigmaPort.addChildNode(enigmaLabel)
		mainNode.addChildNode(enigmaPort)
		
		thrusterPort = SCNPort(host: self, input:Item.self)
		thrusterPort.position = SCNVector3(x: distance, y: templates.lineSpacing, z: 0)
		thrusterLabel = SCNLabel(text: "thruster", scale: 0.1, align: alignment.left)
		thrusterLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		thrusterPort.addChildNode(thrusterLabel)
		mainNode.addChildNode(thrusterPort)
		
		radioPort = SCNPort(host: self, input:Item.self)
		radioPort.position = SCNVector3(x: distance, y: 0, z: 0)
		radioLabel = SCNLabel(text: "radio", scale: 0.1, align: alignment.left)
		radioLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		radioPort.addChildNode(radioLabel)
		mainNode.addChildNode(radioPort)
		
		mapPort = SCNPort(host: self, input:Item.self)
		mapPort.position = SCNVector3(x: distance, y:  2 * templates.lineSpacing, z: 0)
		mapLabel = SCNLabel(text: "cloak", scale: 0.1, align: alignment.left)
		mapLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		mapPort.addChildNode(mapLabel)
		mainNode.addChildNode(mapPort)
		
		shieldPort = SCNPort(host: self, input:Item.self)
		shieldPort.position = SCNVector3(x: distance, y: 2 * -templates.lineSpacing, z: 0)
		shieldLabel = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		shieldLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		shieldPort.addChildNode(shieldLabel)
		mainNode.addChildNode(shieldPort)
		
		enigmaLabel.update("--", color: grey)
		thrusterLabel.update("--", color: grey)
		radioLabel.update("--", color: grey)
		mapLabel.update("--", color: grey)
		shieldLabel.update("--", color: grey)
		
		port.input = Item.self
		port.output = Event.self
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(0,0,-1),host:self))
		
		// Start
		installThruster()
	}
	
	// MARK: Add Modules -
	
	func installEnigma()
	{
		enigmaPort.enable()
		enigmaLabel.update("enigma",color:white)
		player.lookAt(deg: 0)
	}
	
	func installThruster()
	{
		thrusterPort.enable()
		thrusterLabel.update("thruster",color:white)
		player.lookAt(deg: 0)
	}
	
	func installRadio()
	{
		radioPort.enable()
		radioLabel.update("radio",color:white)
		player.lookAt(deg: 0)
	}
	
	func installMap()
	{
		mapPort.enable()
		mapLabel.update("map",color:white)
		player.lookAt(deg: 0)
	}
	
	func installShield()
	{
		shieldPort.enable()
		shieldLabel.update("shield",color:white)
		player.lookAt(deg: 0)
	}
	
	// MARK: Flags -
	
	override func listen(event: Event)
	{
		
	}
	
	override func onConnect()
	{
		if thrusterPort.isReceivingItemOfType(.battery) == true { thruster.refresh() }
	}
	
	override func onDisconnect()
	{
		if thrusterPort.isReceivingItemOfType(.battery) == false { thruster.refresh() }
	}
	
	func isThrusterPowered() -> Bool
	{
		return false
	}
	
	func isRadioPowered() -> Bool
	{
		return false
	}
	
	func isMapPowered() -> Bool
	{
		return false
	}
	
	func isShieldPowered() -> Bool
	{
		return false
	}
	
	func hasCell(target:Event) -> Bool
	{
		if cellPort1.event != nil && cellPort1.event == target { return true }
		if cellPort2.event != nil && cellPort2.event == target { return true }
		if cellPort3.event != nil && cellPort3.event == target { return true }
		return false
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		player.lookAt(deg: 0)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}