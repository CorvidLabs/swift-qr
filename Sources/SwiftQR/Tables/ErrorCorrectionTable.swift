internal enum ErrorCorrectionTable {
    struct BlockConfiguration {
        let group1Blocks: Int
        let group1DataCodewords: Int
        let group2Blocks: Int
        let group2DataCodewords: Int
        let ecCodewordsPerBlock: Int

        var totalDataCodewords: Int {
            return group1Blocks * group1DataCodewords + group2Blocks * group2DataCodewords
        }

        var totalBlocks: Int {
            return group1Blocks + group2Blocks
        }
    }

    // [version][errorCorrection: L,M,Q,H]
    // Format: (ecPerBlock, g1Blocks, g1Data, g2Blocks, g2Data)
    private static let configurations: [[BlockConfiguration]] = [
        [],
        // Version 1
        [
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 19, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 7),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 16, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 10),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 13, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 13),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 9, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 17),
        ],
        // Version 2
        [
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 34, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 10),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 28, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 16),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 22, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 22),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 16, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 28),
        ],
        // Version 3
        [
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 55, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 15),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 44, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 17, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 18),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 13, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 22),
        ],
        // Version 4
        [
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 80, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 20),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 32, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 18),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 24, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 9, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 16),
        ],
        // Version 5
        [
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 108, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 43, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 15, group2Blocks: 2, group2DataCodewords: 16, ecCodewordsPerBlock: 18),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 11, group2Blocks: 2, group2DataCodewords: 12, ecCodewordsPerBlock: 22),
        ],
        // Version 6
        [
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 68, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 18),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 27, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 16),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 19, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 15, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 28),
        ],
        // Version 7
        [
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 78, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 20),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 31, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 18),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 14, group2Blocks: 4, group2DataCodewords: 15, ecCodewordsPerBlock: 18),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 13, group2Blocks: 1, group2DataCodewords: 14, ecCodewordsPerBlock: 26),
        ],
        // Version 8
        [
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 97, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 38, group2Blocks: 2, group2DataCodewords: 39, ecCodewordsPerBlock: 22),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 18, group2Blocks: 2, group2DataCodewords: 19, ecCodewordsPerBlock: 22),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 14, group2Blocks: 2, group2DataCodewords: 15, ecCodewordsPerBlock: 26),
        ],
        // Version 9
        [
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 116, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 36, group2Blocks: 2, group2DataCodewords: 37, ecCodewordsPerBlock: 22),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 16, group2Blocks: 4, group2DataCodewords: 17, ecCodewordsPerBlock: 20),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 12, group2Blocks: 4, group2DataCodewords: 13, ecCodewordsPerBlock: 24),
        ],
        // Version 10
        [
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 68, group2Blocks: 2, group2DataCodewords: 69, ecCodewordsPerBlock: 18),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 43, group2Blocks: 1, group2DataCodewords: 44, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 6, group1DataCodewords: 19, group2Blocks: 2, group2DataCodewords: 20, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 6, group1DataCodewords: 15, group2Blocks: 2, group2DataCodewords: 16, ecCodewordsPerBlock: 28),
        ],
        // Version 11
        [
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 81, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 20),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 50, group2Blocks: 4, group2DataCodewords: 51, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 22, group2Blocks: 4, group2DataCodewords: 23, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 12, group2Blocks: 8, group2DataCodewords: 13, ecCodewordsPerBlock: 24),
        ],
        // Version 12
        [
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 92, group2Blocks: 2, group2DataCodewords: 93, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 6, group1DataCodewords: 36, group2Blocks: 2, group2DataCodewords: 37, ecCodewordsPerBlock: 22),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 20, group2Blocks: 6, group2DataCodewords: 21, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 7, group1DataCodewords: 14, group2Blocks: 4, group2DataCodewords: 15, ecCodewordsPerBlock: 28),
        ],
        // Version 13
        [
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 107, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 8, group1DataCodewords: 37, group2Blocks: 1, group2DataCodewords: 38, ecCodewordsPerBlock: 22),
            BlockConfiguration(group1Blocks: 8, group1DataCodewords: 20, group2Blocks: 4, group2DataCodewords: 21, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 12, group1DataCodewords: 11, group2Blocks: 4, group2DataCodewords: 12, ecCodewordsPerBlock: 22),
        ],
        // Version 14
        [
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 115, group2Blocks: 1, group2DataCodewords: 116, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 40, group2Blocks: 5, group2DataCodewords: 41, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 11, group1DataCodewords: 16, group2Blocks: 5, group2DataCodewords: 17, ecCodewordsPerBlock: 20),
            BlockConfiguration(group1Blocks: 11, group1DataCodewords: 12, group2Blocks: 5, group2DataCodewords: 13, ecCodewordsPerBlock: 24),
        ],
        // Version 15
        [
            BlockConfiguration(group1Blocks: 5, group1DataCodewords: 87, group2Blocks: 1, group2DataCodewords: 88, ecCodewordsPerBlock: 22),
            BlockConfiguration(group1Blocks: 5, group1DataCodewords: 41, group2Blocks: 5, group2DataCodewords: 42, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 5, group1DataCodewords: 24, group2Blocks: 7, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 11, group1DataCodewords: 12, group2Blocks: 7, group2DataCodewords: 13, ecCodewordsPerBlock: 24),
        ],
        // Version 16
        [
            BlockConfiguration(group1Blocks: 5, group1DataCodewords: 98, group2Blocks: 1, group2DataCodewords: 99, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 7, group1DataCodewords: 45, group2Blocks: 3, group2DataCodewords: 46, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 15, group1DataCodewords: 19, group2Blocks: 2, group2DataCodewords: 20, ecCodewordsPerBlock: 24),
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 15, group2Blocks: 13, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 17
        [
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 107, group2Blocks: 5, group2DataCodewords: 108, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 10, group1DataCodewords: 46, group2Blocks: 1, group2DataCodewords: 47, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 22, group2Blocks: 15, group2DataCodewords: 23, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 14, group2Blocks: 17, group2DataCodewords: 15, ecCodewordsPerBlock: 28),
        ],
        // Version 18
        [
            BlockConfiguration(group1Blocks: 5, group1DataCodewords: 120, group2Blocks: 1, group2DataCodewords: 121, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 9, group1DataCodewords: 43, group2Blocks: 4, group2DataCodewords: 44, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 17, group1DataCodewords: 22, group2Blocks: 1, group2DataCodewords: 23, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 14, group2Blocks: 19, group2DataCodewords: 15, ecCodewordsPerBlock: 28),
        ],
        // Version 19
        [
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 113, group2Blocks: 4, group2DataCodewords: 114, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 44, group2Blocks: 11, group2DataCodewords: 45, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 17, group1DataCodewords: 21, group2Blocks: 4, group2DataCodewords: 22, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 9, group1DataCodewords: 13, group2Blocks: 16, group2DataCodewords: 14, ecCodewordsPerBlock: 26),
        ],
        // Version 20
        [
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 107, group2Blocks: 5, group2DataCodewords: 108, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 41, group2Blocks: 13, group2DataCodewords: 42, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 15, group1DataCodewords: 24, group2Blocks: 5, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 15, group1DataCodewords: 15, group2Blocks: 10, group2DataCodewords: 16, ecCodewordsPerBlock: 28),
        ],
        // Version 21
        [
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 116, group2Blocks: 4, group2DataCodewords: 117, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 17, group1DataCodewords: 42, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 17, group1DataCodewords: 22, group2Blocks: 6, group2DataCodewords: 23, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 19, group1DataCodewords: 16, group2Blocks: 6, group2DataCodewords: 17, ecCodewordsPerBlock: 30),
        ],
        // Version 22
        [
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 111, group2Blocks: 7, group2DataCodewords: 112, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 17, group1DataCodewords: 46, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 7, group1DataCodewords: 24, group2Blocks: 16, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 34, group1DataCodewords: 13, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 24),
        ],
        // Version 23
        [
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 121, group2Blocks: 5, group2DataCodewords: 122, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 47, group2Blocks: 14, group2DataCodewords: 48, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 11, group1DataCodewords: 24, group2Blocks: 14, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 16, group1DataCodewords: 15, group2Blocks: 14, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 24
        [
            BlockConfiguration(group1Blocks: 6, group1DataCodewords: 117, group2Blocks: 4, group2DataCodewords: 118, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 6, group1DataCodewords: 45, group2Blocks: 14, group2DataCodewords: 46, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 11, group1DataCodewords: 24, group2Blocks: 16, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 30, group1DataCodewords: 16, group2Blocks: 2, group2DataCodewords: 17, ecCodewordsPerBlock: 30),
        ],
        // Version 25
        [
            BlockConfiguration(group1Blocks: 8, group1DataCodewords: 106, group2Blocks: 4, group2DataCodewords: 107, ecCodewordsPerBlock: 26),
            BlockConfiguration(group1Blocks: 8, group1DataCodewords: 47, group2Blocks: 13, group2DataCodewords: 48, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 7, group1DataCodewords: 24, group2Blocks: 22, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 22, group1DataCodewords: 15, group2Blocks: 13, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 26
        [
            BlockConfiguration(group1Blocks: 10, group1DataCodewords: 114, group2Blocks: 2, group2DataCodewords: 115, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 19, group1DataCodewords: 46, group2Blocks: 4, group2DataCodewords: 47, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 28, group1DataCodewords: 22, group2Blocks: 6, group2DataCodewords: 23, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 33, group1DataCodewords: 16, group2Blocks: 4, group2DataCodewords: 17, ecCodewordsPerBlock: 30),
        ],
        // Version 27
        [
            BlockConfiguration(group1Blocks: 8, group1DataCodewords: 122, group2Blocks: 4, group2DataCodewords: 123, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 22, group1DataCodewords: 45, group2Blocks: 3, group2DataCodewords: 46, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 8, group1DataCodewords: 23, group2Blocks: 26, group2DataCodewords: 24, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 12, group1DataCodewords: 15, group2Blocks: 28, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 28
        [
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 117, group2Blocks: 10, group2DataCodewords: 118, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 3, group1DataCodewords: 45, group2Blocks: 23, group2DataCodewords: 46, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 24, group2Blocks: 31, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 11, group1DataCodewords: 15, group2Blocks: 31, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 29
        [
            BlockConfiguration(group1Blocks: 7, group1DataCodewords: 116, group2Blocks: 7, group2DataCodewords: 117, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 21, group1DataCodewords: 45, group2Blocks: 7, group2DataCodewords: 46, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 1, group1DataCodewords: 23, group2Blocks: 37, group2DataCodewords: 24, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 19, group1DataCodewords: 15, group2Blocks: 26, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 30
        [
            BlockConfiguration(group1Blocks: 5, group1DataCodewords: 115, group2Blocks: 10, group2DataCodewords: 116, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 19, group1DataCodewords: 47, group2Blocks: 10, group2DataCodewords: 48, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 15, group1DataCodewords: 24, group2Blocks: 25, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 23, group1DataCodewords: 15, group2Blocks: 25, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 31
        [
            BlockConfiguration(group1Blocks: 13, group1DataCodewords: 115, group2Blocks: 3, group2DataCodewords: 116, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 46, group2Blocks: 29, group2DataCodewords: 47, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 42, group1DataCodewords: 24, group2Blocks: 1, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 23, group1DataCodewords: 15, group2Blocks: 28, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 32
        [
            BlockConfiguration(group1Blocks: 17, group1DataCodewords: 115, group2Blocks: 0, group2DataCodewords: 0, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 10, group1DataCodewords: 46, group2Blocks: 23, group2DataCodewords: 47, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 10, group1DataCodewords: 24, group2Blocks: 35, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 19, group1DataCodewords: 15, group2Blocks: 35, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 33
        [
            BlockConfiguration(group1Blocks: 17, group1DataCodewords: 115, group2Blocks: 1, group2DataCodewords: 116, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 14, group1DataCodewords: 46, group2Blocks: 21, group2DataCodewords: 47, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 29, group1DataCodewords: 24, group2Blocks: 19, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 11, group1DataCodewords: 15, group2Blocks: 46, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 34
        [
            BlockConfiguration(group1Blocks: 13, group1DataCodewords: 115, group2Blocks: 6, group2DataCodewords: 116, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 14, group1DataCodewords: 46, group2Blocks: 23, group2DataCodewords: 47, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 44, group1DataCodewords: 24, group2Blocks: 7, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 59, group1DataCodewords: 16, group2Blocks: 1, group2DataCodewords: 17, ecCodewordsPerBlock: 30),
        ],
        // Version 35
        [
            BlockConfiguration(group1Blocks: 12, group1DataCodewords: 121, group2Blocks: 7, group2DataCodewords: 122, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 12, group1DataCodewords: 47, group2Blocks: 26, group2DataCodewords: 48, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 39, group1DataCodewords: 24, group2Blocks: 14, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 22, group1DataCodewords: 15, group2Blocks: 41, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 36
        [
            BlockConfiguration(group1Blocks: 6, group1DataCodewords: 121, group2Blocks: 14, group2DataCodewords: 122, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 6, group1DataCodewords: 47, group2Blocks: 34, group2DataCodewords: 48, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 46, group1DataCodewords: 24, group2Blocks: 10, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 2, group1DataCodewords: 15, group2Blocks: 64, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 37
        [
            BlockConfiguration(group1Blocks: 17, group1DataCodewords: 122, group2Blocks: 4, group2DataCodewords: 123, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 29, group1DataCodewords: 46, group2Blocks: 14, group2DataCodewords: 47, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 49, group1DataCodewords: 24, group2Blocks: 10, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 24, group1DataCodewords: 15, group2Blocks: 46, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 38
        [
            BlockConfiguration(group1Blocks: 4, group1DataCodewords: 122, group2Blocks: 18, group2DataCodewords: 123, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 13, group1DataCodewords: 46, group2Blocks: 32, group2DataCodewords: 47, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 48, group1DataCodewords: 24, group2Blocks: 14, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 42, group1DataCodewords: 15, group2Blocks: 32, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 39
        [
            BlockConfiguration(group1Blocks: 20, group1DataCodewords: 117, group2Blocks: 4, group2DataCodewords: 118, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 40, group1DataCodewords: 47, group2Blocks: 7, group2DataCodewords: 48, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 43, group1DataCodewords: 24, group2Blocks: 22, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 10, group1DataCodewords: 15, group2Blocks: 67, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
        // Version 40
        [
            BlockConfiguration(group1Blocks: 19, group1DataCodewords: 118, group2Blocks: 6, group2DataCodewords: 119, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 18, group1DataCodewords: 47, group2Blocks: 31, group2DataCodewords: 48, ecCodewordsPerBlock: 28),
            BlockConfiguration(group1Blocks: 34, group1DataCodewords: 24, group2Blocks: 34, group2DataCodewords: 25, ecCodewordsPerBlock: 30),
            BlockConfiguration(group1Blocks: 20, group1DataCodewords: 15, group2Blocks: 61, group2DataCodewords: 16, ecCodewordsPerBlock: 30),
        ],
    ]

    static func blockConfig(version: Int, errorCorrection: QRErrorCorrectionLevel) -> BlockConfiguration {
        guard version >= 1 && version <= 40 else {
            fatalError("Invalid QR version: \(version)")
        }
        return configurations[version][errorCorrection.tableIndex]
    }

    static func totalCodewords(version: Int) -> Int {
        let size = 21 + (version - 1) * 4
        var modules = size * size

        modules -= 3 * 64
        modules -= 3 * 15
        modules -= 2 * (size - 16)

        if version >= 2 {
            let alignmentCount = AlignmentPatternTable.centers(for: version).count
            modules -= alignmentCount * 25
        }

        modules -= 31

        if version >= 7 {
            modules -= 36
        }

        return modules / 8
    }
}
