
import MetalKit

class TextureLoader {

    public static func CreateTexture(textureName: String, ext: String)->MTLTexture?{
       
        
        if let url = Bundle.main.url(forResource: textureName, withExtension: ext) {
            var result: MTLTexture?
            let textureLoader = MTKTextureLoader(device: DarkEngine.Device)
            
            let options = [MTKTextureLoader.Option.origin : MTKTextureLoader.Origin.topLeft]
            
            do{
                result = try textureLoader.newTexture(URL: url, options: options)
            }catch let error as NSError {
                print("ERROR::CREATE::TEXTURE::__\(textureName)__::\(error)")
            }
            
            return result
        }else {
            print("ERROR::CREATE::TEXTURE::__\(textureName).\(ext)__")
        }
        
        return nil
       
    }
    
}
