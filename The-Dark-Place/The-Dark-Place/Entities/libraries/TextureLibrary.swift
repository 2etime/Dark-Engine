
import MetalKit

enum TextureTypes {
    case None
    case Grass
    case Face
    case StandingGrass
    case Cruiser
}

class TextureLibrary: Library<TextureTypes, MTLTexture> {
    
    private var library: [TextureTypes : Texture] = [:]
    
    override func fillLibrary() {
        library.updateValue(Texture("grass"), forKey: .Grass)
        library.updateValue(Texture("face"), forKey: .Face)
        library.updateValue(Texture("standing_grass"), forKey: .StandingGrass)
        library.updateValue(Texture("cruiser", ext: "bmp"), forKey: .Cruiser)
    }
    
    public func addTexture(_ textureType: TextureTypes){
        
    }
    
    override subscript(_ type: TextureTypes) -> MTLTexture? {
        return library[type]?.texture
    }
    
}

class Texture {
    var texture: MTLTexture!
    
    init(_ textureName: String, ext: String = "png"){
        let textureLoader = TextureLoader(textureName: textureName, textureExtension: ext)
        self.texture = textureLoader.loadTextureFromBundle()
    }
}
