//
//  ParticlesView.swift
//  WeatherApp
//
//  Created by Timur Begishev on 07.02.2021.
//

import UIKit
import SpriteKit

class ParticlesView: SKView {
	override func didMoveToSuperview() {
		let scene = SKScene(size: self.frame.size)
		scene.backgroundColor = .clear
		self.presentScene(scene)
		
		self.allowsTransparency = true
		self.backgroundColor = .clear
		
		if let particles = SKEmitterNode(fileNamed: "MyParticle.sks") {
			particles.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height)
			particles.particlePositionRange = CGVector(dx: self.bounds.size.width, dy: 0)
			scene.addChild(particles)
		}
	}
}
