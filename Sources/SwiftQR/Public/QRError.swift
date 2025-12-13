public enum QRError: Error, Sendable {
    case dataTooLong(maxCapacity: Int, actualLength: Int)
    case invalidCharacter(Character, mode: QREncodingMode)
    case versionOutOfRange(Int)
    case encodingFailed(String)
    case internalError(String)
}
