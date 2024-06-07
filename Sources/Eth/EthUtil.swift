import Foundation

enum EthUtil {
    static func chunkData(data: Data, chunkSize: Int) -> [Data] {
        var chunks = [Data]()
        let totalChunks = (data.count + chunkSize - 1) / chunkSize

        for i in 0 ..< totalChunks {
            let start = i * chunkSize
            let end = min(start + chunkSize, data.count)
            let chunk = data.subdata(in: start ..< end)
            chunks.append(chunk)
        }

        return chunks
    }

    static func showChunkedWords(_ data: Data) -> String {
        data.isEmpty
            ? "000: " :
            chunkData(data: data, chunkSize: 32).enumerated().map { "\(String(format: "%03X", $0 * 32)): \(Hex.toHex($1))" }.joined(separator: "\n\t\t")
    }
}
