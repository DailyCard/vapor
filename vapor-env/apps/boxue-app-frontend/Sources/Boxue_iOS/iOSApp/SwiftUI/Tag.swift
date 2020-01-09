//
//  Tag.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/14.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI

struct Tag: View {
  var color: Color = .orange
  var tl: CGFloat = 0
  var tr: CGFloat = 0
  var bl: CGFloat = 0
  var br: CGFloat = 0
  
  var body: some View {
    GeometryReader { geometry in
      Path { path in
        let w = geometry.size.width
        let h = geometry.size.height
        
        let tl = min(min(self.tl, h/2), w/2)
        let tr = min(min(self.tr, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)
        
        path.move(to: CGPoint(x: w/2, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(
          center: CGPoint(x: w - tr, y: tr),
          radius: tr,
          startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0),
          clockwise: false)
        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(
          center: CGPoint(x: w - br, y: h - br),
          radius: br,
          startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90),
          clockwise: false)
        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(
          center: CGPoint(x: bl, y: h - bl),
          radius: bl,
          startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180),
          clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(
          center: CGPoint(x: tl, y: tl),
          radius: tl,
          startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270),
          clockwise: false)
      }
      .fill(self.color)
    }
  }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
      HStack {
        Text("Swift")
          .foregroundColor(.black).font(.headline).padding(15)
          .frame(height: 30)
          .overlay(Tag(color: .green, tr: 15, bl: 15).opacity(0.5))
        
        Text("UI")
          .foregroundColor(.black).font(.headline).padding(15)
          .frame(height: 30)
          .overlay(Tag(color: .blue, tl: 30, br: 30).opacity(0.5))
      }
    }
}
