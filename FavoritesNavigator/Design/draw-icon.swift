import Foundation
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

func rgb(_ hex: UInt32, _ a: CGFloat = 1) -> CGColor {
    CGColor(srgbRed: CGFloat((hex >> 16) & 0xFF) / 255, green: CGFloat((hex >> 8) & 0xFF) / 255, blue: CGFloat(hex & 0xFF) / 255, alpha: a)
}
let teal = rgb(0x0E7C86), deepTeal = rgb(0x07484F), sand = rgb(0xF6E7C8), coral = rgb(0xF2654B), white = rgb(0xFFFFFF)

func makeContext(_ size: Int, opaque: Bool) -> CGContext {
    let info = opaque ? CGImageAlphaInfo.noneSkipLast.rawValue : CGImageAlphaInfo.premultipliedLast.rawValue
    let ctx = CGContext(data: nil, width: size, height: size, bitsPerComponent: 8, bytesPerRow: 0,
                        space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: info)!
    ctx.translateBy(x: 0, y: CGFloat(size)); ctx.scaleBy(x: 1, y: -1)
    return ctx
}

func drawArt(_ ctx: CGContext, _ s: CGFloat) {
    let g = CGGradient(colorsSpace: CGColorSpace(name: CGColorSpace.sRGB)!, colors: [teal, deepTeal] as CFArray, locations: [0, 1])!
    ctx.drawLinearGradient(g, start: .zero, end: CGPoint(x: 0, y: s), options: [])

    let c = CGPoint(x: s / 2, y: s * 0.56), r = s * 0.30
    let globe = CGRect(x: c.x - r, y: c.y - r, width: 2 * r, height: 2 * r)
    ctx.setFillColor(sand); ctx.fillEllipse(in: globe)

    ctx.saveGState()
    ctx.addEllipse(in: globe); ctx.clip()
    ctx.setStrokeColor(teal); ctx.setLineWidth(s * 0.018)
    for k in [-0.5, 0.0, 0.5] as [CGFloat] {
        let y = c.y + r * k
        ctx.move(to: CGPoint(x: c.x - r, y: y)); ctx.addLine(to: CGPoint(x: c.x + r, y: y))
    }
    ctx.strokePath()
    for w in [0.0, 0.5, 0.85] as [CGFloat] {
        ctx.strokeEllipse(in: CGRect(x: c.x - r * w, y: c.y - r, width: 2 * r * w, height: 2 * r))
    }
    ctx.move(to: CGPoint(x: c.x, y: c.y - r)); ctx.addLine(to: CGPoint(x: c.x, y: c.y + r)); ctx.strokePath()
    ctx.restoreGState()
    ctx.setStrokeColor(white); ctx.setLineWidth(s * 0.022); ctx.strokeEllipse(in: globe)

    let pc = CGPoint(x: s * 0.66, y: s * 0.30), pr = s * 0.12
    ctx.setShadow(offset: CGSize(width: 0, height: s * 0.01), blur: s * 0.03, color: rgb(0x000000, 0.3))
    ctx.beginPath()
    ctx.addArc(center: pc, radius: pr, startAngle: .pi * 0.8, endAngle: .pi * 0.2, clockwise: false)
    ctx.addLine(to: CGPoint(x: pc.x, y: pc.y + pr * 2.1))
    ctx.closePath()
    ctx.setFillColor(coral); ctx.fillPath()
    ctx.setShadow(offset: .zero, blur: 0, color: nil)
    ctx.setFillColor(white)
    ctx.fillEllipse(in: CGRect(x: pc.x - pr * 0.42, y: pc.y - pr * 0.42, width: pr * 0.84, height: pr * 0.84))
}

func save(_ ctx: CGContext, _ path: String) {
    let dest = CGImageDestinationCreateWithURL(URL(fileURLWithPath: path) as CFURL, UTType.png.identifier as CFString, 1, nil)!
    CGImageDestinationAddImage(dest, ctx.makeImage()!, nil)
    CGImageDestinationFinalize(dest)
}

let args = CommandLine.arguments
let icon = makeContext(1024, opaque: true)
drawArt(icon, 1024)
save(icon, args[1])

let logoSize = 600
let logo = makeContext(logoSize, opaque: false)
let rect = CGRect(x: 0, y: 0, width: logoSize, height: logoSize)
logo.addPath(CGPath(roundedRect: rect, cornerWidth: CGFloat(logoSize) * 0.225, cornerHeight: CGFloat(logoSize) * 0.225, transform: nil))
logo.clip()
drawArt(logo, CGFloat(logoSize))
save(logo, args[2])
