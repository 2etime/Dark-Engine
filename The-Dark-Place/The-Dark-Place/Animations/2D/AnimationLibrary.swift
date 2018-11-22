import MetalKit

enum AnimationTypes2D {
    case Barbarian
}

class Animation2DLibrary: Library<AnimationTypes2D, Animation2D> {
    private var _spriteSheets: SpriteSheetLibrary!
    private var library: [AnimationTypes2D: Animation2D] = [:]
    
    init(spriteSheetLibrary: SpriteSheetLibrary){
        self._spriteSheets = spriteSheetLibrary
    }
    
    override func fillLibrary() {
        let animation = Animation2D(speed: 5, textures:
            _spriteSheets[.Player].grabImage(col: 1, row: 1, width: 32, height: 32, rowSpan: 2)
        )
        
        library.updateValue(animation, forKey: .Barbarian)
    }
    
    override subscript(_ type: AnimationTypes2D) -> Animation2D {
        return (library[type])!
    }
    
}

class Animation2D {
    
    private var speed: Float = 0
    private var frames: Int = 0
    
    private var index: Int = 0
    private var count: Int = 0
    private var currentImage: MTLTexture!
    private var image: MTLTexture!
    var images: [MTLTexture] = []
    
    init(speed: Float, textures: MTLTexture...){
        self.speed = speed
        self.images = textures
        self.frames = textures.count
        self.currentImage = textures[0]
    }
    
    func setSpeed(_ speed: Float){
        self.speed = speed
    }
    
    func runAnimation(){
        index += 1
        if(Float(index) > speed){
            index = 0
            nextFrame()
        }
    }
    
    func nextFrame(){
        for i in 0..<frames {
            if(count == i){
                currentImage = images[i]
            }
        }
        count += 1
        if(count >= frames){
            count = 0
        }
    }
    
    func getFrame()->MTLTexture{
        return currentImage
    }
    
    
}
