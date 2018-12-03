import Foundation

class BufferedFileReader {
    
    private var _lines: [String] = []
    private var _currentLine: Int = 0
    
    public var hasNextLine: Bool {
        return _currentLine < _lines.count
    }
    
    init(bundleFileName: String) {
        if let url = Bundle.main.url(forResource: bundleFileName, withExtension: "fnt"){
            do {
                let contents = try String(contentsOf: url)
                contents.enumerateLines { line, _ in
                    self._lines.append(line)
                }
            }catch{
                print("ERROR::LOADING::BUFFERED-READER-FILE::__\(bundleFileName)__\n::\(error)")
            }
        }
    }
    
    public func nextLine()->String? {
        var line: String? = nil
        if(hasNextLine){
            line = _lines[_currentLine]
            _currentLine += 1
        }
        return line
    }
}
