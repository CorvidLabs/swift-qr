import SwiftQR
import Foundation

// Generate QR code for README
let url = "https://github.com/CorvidLabs/swift-qr"
let qr = try! QRCode.encode(url, errorCorrection: .medium)

// Generate PNG
let pngData = qr.png(moduleSize: 10, quietZone: 4)
let pngPath = "/tmp/swift-qr-demo.png"
let pngURL = URL(fileURLWithPath: pngPath)
try! Data(pngData).write(to: pngURL)
print("Generated PNG: \(pngPath)")
print("Size: \(qr.size)x\(qr.size) modules")
print("Version: \(qr.version.number)")
print("PNG bytes: \(pngData.count)")
