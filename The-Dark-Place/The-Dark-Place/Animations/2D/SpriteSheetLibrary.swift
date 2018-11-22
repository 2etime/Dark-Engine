import MetalKit

enum SpriteSheetTypes {
    case Player
}


class SpriteSheetLibrary: Library<SpriteSheetTypes, SpriteSheet> {
    private var library: [SpriteSheetTypes: SpriteSheet] = [:]
    
    override func fillLibrary() {
//        library.updateValue(SpriteSheet(textureName: "barbarian.png"), forKey: .Player)
        library.updateValue(SpriteSheet(textureName: "players.png"), forKey: .Player)
    }
    
    override subscript(_ type: SpriteSheetTypes) -> SpriteSheet {
        return (library[type])!
    }

}

class SpriteSheet {
    var image: CGImage!
    
    init(textureName: String){
        let url = Bundle.main.url(forResource: textureName, withExtension: nil)
        let image = NSImage(byReferencing: url!)
        self.image = image.CGImage
    }
    
    func grabImage(x: Int, y: Int, width: Int, height: Int)->MTLTexture {
        let textureLoader = MTKTextureLoader(device: DarkEngine.Device)
        let crop = NSRect(x: x,
                          y: y,
                          width: width,
                          height: height)
        
        
        let cgImage = image.cropping(to: crop)!
        var texture: MTLTexture!
        let originOption = [MTKTextureLoader.Option.origin:MTKTextureLoader.Origin.topLeft]
        do{
            texture = try textureLoader.newTexture(cgImage: cgImage, options: originOption)
        }catch let textureLoadError as NSError{
            print("ERROR::TEXTURE_LOADING::\(textureLoadError)")
        }
        return texture
    }
    
    func grabImage(col: Int, row: Int, width: Int, height: Int, colSpan: Int = 1, rowSpan: Int = 1)->MTLTexture {
        let textureLoader = MTKTextureLoader(device: DarkEngine.Device)
        let crop = NSRect(x: (col * width) - width,
                          y: (row * height) - height,
                          width: width * colSpan,
                          height: height * rowSpan)
        
        
        let cgImage = image.cropping(to: crop)!
        var texture: MTLTexture!
        let originOption = [MTKTextureLoader.Option.origin:MTKTextureLoader.Origin.topLeft]
        do{
            texture = try textureLoader.newTexture(cgImage: cgImage, options: originOption)
        }catch let textureLoadError as NSError{
            print("ERROR::TEXTURE_LOADING::\(textureLoadError)")
        }
        return texture
    }
}
