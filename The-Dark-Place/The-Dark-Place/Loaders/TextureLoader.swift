import MetalKit

public enum TextureOrigin {
    case TopLeft
    case BottomLeft
}

class TextureLoader {
    private var textureName: String!
    private var textureExtension: String!
    private var origin: MTKTextureLoader.Origin!
    
    init(textureName: String, textureExtension: String = "png", origin: TextureOrigin = TextureOrigin.TopLeft){
        self.textureName = textureName
        self.textureExtension = textureExtension
        setTextureOrigin(origin)
    }
    
    ///Must call this before any generator function if you want to change the origin type
    public func setTextureOrigin(_ textureOrigin: TextureOrigin){
        switch textureOrigin {
        case .TopLeft:
            origin = MTKTextureLoader.Origin.topLeft
        case .BottomLeft:
            origin = MTKTextureLoader.Origin.bottomLeft
        }
    }
    
    public func loadTextureFromBundle()->MTLTexture{
        var result: MTLTexture!
        
        if let url = Bundle.main.url(forResource: textureName, withExtension: textureExtension) {
            let textureLoader = MTKTextureLoader(device: DarkEngine.Device)
            
            let options: [MTKTextureLoader.Option : Any] = [MTKTextureLoader.Option.origin : origin]
            
            do{
                result = try textureLoader.newTexture(URL: url, options: options)
            }catch let error as NSError {
                print("ERROR::CREATE::TEXTURE::__\(textureName!)__::\(error)")
            }
        }else {
            print("ERROR::CREATE::TEXTURE::__\(textureName!).\(textureExtension!)__")
        }
        
        return result
    }
    
}
