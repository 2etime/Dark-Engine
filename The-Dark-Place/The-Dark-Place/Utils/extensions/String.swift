
import simd

extension String {
    
    func split(_ character: String)->[String]{
        return self.split(separator: Character(character)).map { String($0) }
    }
    
    var intValue: Int {
        return Int(self)!
    }
    
    var floatValue: Float {
        return Float(self)!
    }
    
    func toIntArray(splitChar: String = ",")->[Int] {
        var result: [Int] = []
        result = self.split(splitChar).map({ (value) in
            return Int(value)!
        })
        return result
    }
    
    var asciiCode: Int {
        var code: UInt32 = 0
        if(self.count > 0){
            code = self.unicodeScalars.map { $0.value }.reduce(0, +)
        }
        return Int(code)
    }
    
    var asciiCodes: [Int] {
        var codes: [Int] = []
        for char in self {
            codes.append(String(char).asciiCode)
        }
        return codes
    }
}
