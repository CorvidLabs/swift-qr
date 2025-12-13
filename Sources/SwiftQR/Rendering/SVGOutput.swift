import ASCIIPixelArt

internal enum SVGOutput {
    static func render(qrCode: QRCode, config: QRCode.SVGConfiguration) -> String {
        let totalSize = qrCode.size + (config.quietZone * 2)
        let canvasWidth = totalSize * config.moduleSize
        let canvasHeight = totalSize * config.moduleSize

        var grid = PixelGrid(width: totalSize, height: totalSize)

        for (x, y, isDark) in qrCode.modules() {
            if isDark {
                let gridX = x + config.quietZone
                let gridY = y + config.quietZone
                grid[gridX, gridY] = config.foregroundColor
            }
        }

        let svgConfig = SVGConfig(
            canvasWidth: canvasWidth,
            canvasHeight: canvasHeight,
            backgroundColor: config.backgroundColor
        )

        return SVGRenderer.render(grid: grid, config: svgConfig)
    }
}
