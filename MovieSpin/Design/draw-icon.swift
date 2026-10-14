// Draws the Movie Spin artwork with Core Graphics (no external images):
//   AppIcon.png      1024x1024, opaque (no alpha), used as the app icon
//   placeholder.png  780x1170, the poster shown before the first spin
//   launch_logo.png  600x600, transparent, used on the launch screen
// The wheel has 10 segments, one per favorite.
//
// Run from the MovieSpin folder:  swift Design/draw-icon.swift <output-folder>

import Foundation
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

func rgb(_ hex: UInt32, _ a: CGFloat = 1) -> CGColor {
    CGColor(srgbRed: CGFloat((hex >> 16) & 0xFF) / 255, green: CGFloat((hex >> 8) & 0xFF) / 255, blue: CGFloat(hex & 0xFF) / 255, alpha: a)
}
let amber = rgb(0xFFB23F), coral = rgb(0xE5533D), ink = rgb(0x0E0E12), rim = rgb(0x2A2A33), white = rgb(0xF5F1E8)

func makeContext(_ w: Int, _ h: Int, opaque: Bool) -> CGContext {
    let info = opaque ? CGImageAlphaInfo.noneSkipLast.rawValue : CGImageAlphaInfo.premultipliedLast.rawValue
    let ctx = CGContext(data: nil, width: w, height: h, bitsPerComponent: 8, bytesPerRow: 0,
                        space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: info)!
    // flip so y goes down
    ctx.translateBy(x: 0, y: CGFloat(h)); ctx.scaleBy(x: 1, y: -1)
    return ctx
}

func background(_ ctx: CGContext, _ w: CGFloat, _ h: CGFloat) {
    let g = CGGradient(colorsSpace: CGColorSpace(name: CGColorSpace.sRGB)!, colors: [rgb(0x2B2B36), rgb(0x0B0B0F)] as CFArray, locations: [0, 1])!
    ctx.drawRadialGradient(g, startCenter: CGPoint(x: w / 2, y: h * 0.42), startRadius: 0,
                           endCenter: CGPoint(x: w / 2, y: h * 0.42), endRadius: max(w, h) * 0.75, options: [.drawsAfterEndLocation])
}

func wheel(_ ctx: CGContext, center c: CGPoint, radius r: CGFloat) {
    // soft glow
    ctx.setShadow(offset: .zero, blur: r * 0.25, color: rgb(0xFFB23F, 0.35))
    ctx.setFillColor(rim); ctx.fillEllipse(in: CGRect(x: c.x - r, y: c.y - r, width: 2 * r, height: 2 * r))
    ctx.setShadow(offset: .zero, blur: 0, color: nil)
    // 10 segments = 10 favorites
    let inner = r * 0.86
    for i in 0..<10 {
        let a0 = CGFloat(i) * .pi / 5 - .pi / 2, a1 = a0 + .pi / 5
        ctx.beginPath(); ctx.move(to: c)
        ctx.addArc(center: c, radius: inner, startAngle: a0, endAngle: a1, clockwise: false)
        ctx.closePath()
        ctx.setFillColor(i % 2 == 0 ? amber : coral); ctx.fillPath()
    }
    // separators
    ctx.setStrokeColor(rim); ctx.setLineWidth(r * 0.025)
    for i in 0..<10 {
        let a = CGFloat(i) * .pi / 5 - .pi / 2
        ctx.move(to: c); ctx.addLine(to: CGPoint(x: c.x + cos(a) * inner, y: c.y + sin(a) * inner))
    }
    ctx.strokePath()
    // rim dots
    ctx.setFillColor(white)
    for i in 0..<20 {
        let a = CGFloat(i) * .pi / 10 - .pi / 2 + .pi / 20
        let p = CGPoint(x: c.x + cos(a) * r * 0.93, y: c.y + sin(a) * r * 0.93)
        let d = r * 0.035
        ctx.fillEllipse(in: CGRect(x: p.x - d, y: p.y - d, width: 2 * d, height: 2 * d))
    }
    // hub
    let hub = r * 0.34
    ctx.setFillColor(ink); ctx.fillEllipse(in: CGRect(x: c.x - hub, y: c.y - hub, width: 2 * hub, height: 2 * hub))
    ctx.setStrokeColor(white); ctx.setLineWidth(r * 0.03)
    ctx.strokeEllipse(in: CGRect(x: c.x - hub, y: c.y - hub, width: 2 * hub, height: 2 * hub))
    // play triangle
    let t = r * 0.16
    ctx.beginPath()
    ctx.move(to: CGPoint(x: c.x - t * 0.7, y: c.y - t))
    ctx.addLine(to: CGPoint(x: c.x + t * 1.0, y: c.y))
    ctx.addLine(to: CGPoint(x: c.x - t * 0.7, y: c.y + t))
    ctx.closePath(); ctx.setFillColor(amber); ctx.fillPath()
    // pointer at the top
    let pw = r * 0.14, top = c.y - r - r * 0.06
    ctx.beginPath()
    ctx.move(to: CGPoint(x: c.x - pw, y: top))
    ctx.addLine(to: CGPoint(x: c.x + pw, y: top))
    ctx.addLine(to: CGPoint(x: c.x, y: top + pw * 1.6))
    ctx.closePath(); ctx.setFillColor(white); ctx.fillPath()
}

func save(_ ctx: CGContext, _ path: String) {
    let img = ctx.makeImage()!
    let dest = CGImageDestinationCreateWithURL(URL(fileURLWithPath: path) as CFURL, UTType.png.identifier as CFString, 1, nil)!
    CGImageDestinationAddImage(dest, img, nil); CGImageDestinationFinalize(dest)
}

let out = CommandLine.arguments[1]
// App icon: 1024x1024, opaque
var ctx = makeContext(1024, 1024, opaque: true)
background(ctx, 1024, 1024)
wheel(ctx, center: CGPoint(x: 512, y: 540), radius: 360)
save(ctx, out + "/AppIcon.png")
// Placeholder poster: 2:3, opaque
ctx = makeContext(780, 1170, opaque: true)
background(ctx, 780, 1170)
wheel(ctx, center: CGPoint(x: 390, y: 600), radius: 250)
save(ctx, out + "/placeholder.png")
// Launch logo: transparent square
ctx = makeContext(600, 600, opaque: false)
wheel(ctx, center: CGPoint(x: 300, y: 312), radius: 250)
save(ctx, out + "/launch_logo.png")
print("done")
