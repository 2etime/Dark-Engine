
import MetalKit

enum TextureTypes {
    case Grass
    case Face
}

class TextureLibrary: Library<TextureTypes, MTLTexture> {
    
    private var library: [TextureTypes : Texture] = [:]
    
    override func fillLibrary() {
        library.updateValue(Texture("grass"), forKey: .Grass)
        library.updateValue(Texture("face"), forKey: .Face)
    }
    
    override subscript(_ type: TextureTypes) -> MTLTexture? {
        return library[type]?.texture
    }
    
}

class Texture {
    var texture: MTLTexture!
    
    init(_ textureName: String, ext: String = "png"){
        self.texture = TextureGenerator.CreateTexture(textureName: textureName, ext: ext)
    }
}