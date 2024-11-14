//
//  ContentView.swift
//  ParticleDemo
//
//  Created by 周辉 on 2024/11/14.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        ParticleView()
            .frame(width: 200, height: 200)
    }
}

struct ParticleView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: 100, y: 100)
        emitter.emitterSize = CGSize(width: 200, height: 200)
        emitter.emitterShape = .rectangle
        
        let colors: [UIColor] = [.red, .green, .blue, .yellow, .purple, .orange]
        var cells: [CAEmitterCell] = []
        
        for color in colors {
            let cell = CAEmitterCell()
            cell.birthRate = 20
            cell.lifetime = 2.0
            cell.velocity = 50
            cell.velocityRange = 20
            cell.emissionRange = .pi * 2
            cell.scale = 0.1
            cell.scaleRange = 0.05
            cell.alphaSpeed = -0.5
            
            let size = CGSize(width: 10, height: 10)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(color.cgColor)
            context.fillEllipse(in: CGRect(origin: .zero, size: size))
            let particleImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            cell.contents = particleImage?.cgImage
            cells.append(cell)
        }
        
        emitter.emitterCells = cells
        emitter.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        view.layer.addSublayer(emitter)

        return view
    }
    

    func updateUIView(_ uiView: UIView, context: Context) {}
}
