
//  Created by Devine Lu Linvega on 2014-09-21.
//  Copyright (c) 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit

var sceneView:SCNView!
var scene = SCNScene()
var touchOrigin = CGPoint()
var touchPosition = CGPoint()

class MainViewController: UIViewController, SCNSceneRendererDelegate
{
    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		sceneView = self.view as! SCNView
		sceneView.scene = scene
		sceneView.backgroundColor = UIColor.black
		sceneView.antialiasingMode = SCNAntialiasingMode.none
		sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
		sceneView.preferredFramesPerSecond = 30
		sceneView.isPlaying = true
		sceneView.showsStatistics = false
		sceneView.delegate = self
		
		//
		
		universe = CoreUniverse()
		game = CoreGame()
		player = CorePlayer()
		helmet = CoreHelmet()
		capsule = CoreCapsule()
		space = CoreSpace()
		
		//
		
		scene.rootNode.addChildNode(player)
		scene.rootNode.addChildNode(helmet)
		scene.rootNode.addChildNode(capsule)
		scene.rootNode.addChildNode(space)
		
		//
		
		universe.whenStart()
		player.whenStart()
		helmet.whenStart()
		capsule.whenStart()
		space.whenStart()
		game.whenStart()
		items.whenStart()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		for touch: AnyObject in touches {
			touchOrigin = touch.location(in: self.view)
		}
		
		player.canAlign = false
		helmet.canAlign = false
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		for touch: AnyObject in touches {
			touchPosition = touch.location(in: self.view)
		}
		
		let dragX = Float(touchPosition.x - touchOrigin.x)
		let dragY = Float(touchPosition.y - touchOrigin.y)
		
		touchOrigin = touchPosition

        player.accelY += (degToRad(dragX/6))
        player.accelX += (degToRad(dragY/6))
        
		helmet.updatePort()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		player.canAlign = true
		helmet.canAlign = true
		helmet.updatePort()
	}
	
	func handleTap(_ gestureRecognize: UIGestureRecognizer)
	{
		let p = gestureRecognize.location(in: sceneView)
		
		let hitResults = sceneView.hitTest(p, options: nil)
		
		if hitResults.count > 0
		{
			let result: AnyObject! = hitResults[0]
			(result.node as! Empty).touch()
		}
	}
	
	func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
	{
		glLineWidth(1)
		
        game.doTic()
        game.doSecond()
		
		capsule.whenRenderer()
		player.whenRenderer()
		helmet.whenRenderer()
		space.whenRenderer()
	}
	
	override var prefersStatusBarHidden : Bool
	{
		return true
	}
}
