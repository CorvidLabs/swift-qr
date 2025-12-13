import PNG

internal enum PNGOutput {
    static func render(qrCode: QRCode, moduleSize: Int = 10, quietZone: Int = 4) -> [UInt8] {
        let totalModules = qrCode.size + (quietZone * 2)
        let imageSize = totalModules * moduleSize

        // Create grayscale pixel data (white background, black modules)
        var pixels: [UInt8] = Array(repeating: 255, count: imageSize * imageSize)

        for y in 0..<qrCode.size {
            for x in 0..<qrCode.size {
                if qrCode.module(at: x, y: y) {
                    // Dark module - fill with black
                    let pixelX = (x + quietZone) * moduleSize
                    let pixelY = (y + quietZone) * moduleSize

                    for dy in 0..<moduleSize {
                        for dx in 0..<moduleSize {
                            let index = (pixelY + dy) * imageSize + (pixelX + dx)
                            pixels[index] = 0
                        }
                    }
                }
            }
        }

        // Encode as PNG
        let image = PNG.Image(
            packing: pixels,
            size: (imageSize, imageSize),
            layout: .init(format: .v8(fill: nil, key: nil))
        )

        var data: [UInt8] = []
        do {
            try image.compress(stream: &data, level: 9)
        } catch {
            return []
        }

        return data
    }
}

extension PNG.Image {
    func compress(stream data: inout [UInt8], level: Int) throws {
        var stream = PNGByteStream(data: &data)
        try self.compress(stream: &stream, level: level)
    }
}

struct PNGByteStream: PNG.BytestreamDestination {
    var dataPointer: UnsafeMutablePointer<[UInt8]>

    init(data: inout [UInt8]) {
        self.dataPointer = withUnsafeMutablePointer(to: &data) { $0 }
    }

    mutating func write(_ buffer: [UInt8]) -> Void? {
        dataPointer.pointee.append(contentsOf: buffer)
        return ()
    }
}
