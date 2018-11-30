import simd

class DarkSizef {
    var width: Float = 0.0
    var height: Float = 0.0
    init(width: Float, height: Float){
        self.width = width > -1 ? width : 0
        self.height = height > -1 ? height : 0
    }
}

class DarkSizei {
    var width: Int = 0
    var height: Int = 0
    init(width: Int, height: Int){
        self.width = width > -1 ? width : 0
        self.height = height > -1 ? height : 0
    }
}
