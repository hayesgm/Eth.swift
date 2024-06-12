import Foundation

func generateSwiftFromAbi() throws {
    let arguments = CommandLine.arguments

    guard arguments.count > 1 else {
        print("Usage: Geno <filePath> --outDir <outDir> --prefix <prefix>")
        return
    }

    var filePath: String?
    var outDir: String?
    var prefix: String?

    var i = 1
    while i < arguments.count {
        switch arguments[i] {
        case "--outDir":
            if i + 1 < arguments.count {
                outDir = arguments[i + 1]
                i += 1
            } else {
                print("Error: --outDir requires a value")
                return
            }
        case "--prefix":
            if i + 1 < arguments.count {
                prefix = arguments[i + 1]
                i += 1
            } else {
                print("Error: --prefix requires a value")
                return
            }
        default:
            if filePath == nil {
                filePath = arguments[i]
            } else {
                print("Error: Unknown argument \(arguments[i])")
                return
            }
        }
        i += 1
    }

    guard let inputFilePath = filePath else {
        print("Error: Missing input file path")
        return
    }

    guard let outputDirectory = outDir else {
        print("Error: Missing output directory")
        return
    }

    let inputFullPath = URL(fileURLWithPath: inputFilePath).standardizedFileURL
    let outputFullPath = URL(fileURLWithPath: outputDirectory).standardizedFileURL

    // Your code to handle the file with the specified options
    print("Input file path: \(inputFullPath)")
    print("Output directory: \(outputFullPath)")
    print("File prefix: \(prefix ?? "")")

    let fileName = inputFullPath.lastPathComponent
    let outFileName = replaceFileExtension(of: fileName, with: "swift")
    let outFile = outputFullPath.appendingPathComponent(outFileName)
    print("outFile: \(outFile)")

    let text = generateAbiFile(input_path: inputFullPath)
    try! text.write(to: outFile, atomically: true, encoding: .utf8)
}

func replaceFileExtension(of fileName: String, with newExtension: String) -> String {
    let fileURL = URL(fileURLWithPath: fileName)
    let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent
    let newFileName = "\(fileNameWithoutExtension).\(newExtension)"
    return newFileName
}

try generateSwiftFromAbi()
