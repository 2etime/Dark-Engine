
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
    
    ///Dynamically add textures to the library
    public func addTexture(_ texture: MTLTexture, _ textureType: TextureTypes){
        library.updateValue(Texture(texture), forKey: textureType)
    }
    
    ///Update texture in library to be a new image.  Useful for storing drawable textures.
    public func UpdateTexture(textureType: TextureTypes, texture: MTLTexture){
        if(library.keys.contains(textureType)){
            library[textureType]?.setTexture(texture)
        }else{
            addTexture(texture, textureType)
        }
    }
    
    override subscript(_ type: TextureTypes) -> MTLTexture? {
        return library[type]?.texture
    }
    
}

class Texture {
    var texture: MTLTexture!
    
    init(_ textureName: String, ext: String = "png"){
        let textureLoader = TextureLoader(textureName: textureName, textureExtension: ext)
        setTexture(textureLoader.loadTextureFromBundle())
    }
    
    init(_ texture: MTLTexture){
        self.setTexture(texture)
    }
    
    func setTexture(_ texture: MTLTexture){
        self.texture = texture
    }
}
