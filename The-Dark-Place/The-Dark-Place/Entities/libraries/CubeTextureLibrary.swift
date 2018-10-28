
import MetalKit

enum CubeTextureTypes {
    case Sky
}

class CubeTextureLibrary: Library<CubeTextureTypes, MTLTexture> {
    
    private var library: [CubeTextureTypes : CubeTextureMap] = [:]
    
    override func fillLibrary() {
        library.updateValue(CubeTextureMap("sky"), forKey: .Sky)
    }
    
    override subscript(_ type: CubeTextureTypes) -> MTLTexture? {
        return library[type]?.texture
    }
    
}

class CubeTextureMap {
    public var texture: MTLTexture!
    private var textureNames: [String] = []
    init(_ cubeNamePrefix: String){
        initializeDictionary(cubePrefix: cubeNamePrefix, ext: "png")
        self.texture = textureCubeWithImagesNamed(ext: "png")
    }
    
    private func initializeDictionary(cubePrefix: String, ext: String){
        let prefix: String = cubePrefix.lowercased()
        textureNames.append("\(prefix)_right")
        textureNames.append("\(prefix)_left")
        textureNames.append("\(prefix)_top")
        textureNames.append("\(prefix)_bottom")
        textureNames.append("\(prefix)_back")
        textureNames.append("\(prefix)_front")
    }
    
    func textureCubeWithImagesNamed(ext: String)->MTLTexture?{
        //Grab the first texture to generate a texture descriptor
        let firstTexture = TextureGenerator.CreateTexture(textureName: textureNames.first!, ext: ext)
        let cubeSize = firstTexture?.width ?? 0
        let textureDescritpor = MTLTextureDescriptor.textureCubeDescriptor(pixelFormat: .bgra8Unorm, size: cubeSize, mipmapped: false)
        let result = DarkEngine.Device.makeTexture(descriptor: textureDescritpor)
        
        for slice in 0..<6 {
            let imageName = textureNames[slice]
            let texture = TextureGenerator.CreateTexture(textureName: imageName, ext: ext)
            let height = texture?.height
            let width = texture?.width
            
            let rowBytes = width! * 4
            let length = rowBytes * height!
            let bgraBytes = [UInt8](repeating: 0, count: length)
            let region = MTLRegionMake2D(0, 0, width!, height!) //Grab the whole texture. ex: start at origin (0,0), go to width/height (1024,1024)
            texture?.getBytes(UnsafeMutableRawPointer(mutating: bgraBytes), bytesPerRow: rowBytes, from: region, mipmapLevel: 0)
            
            result?.replace(region: MTLRegionMake2D(0, 0, cubeSize, cubeSize),
                            mipmapLevel: 0,
                            slice: slice,
                            withBytes: bgraBytes,
                            bytesPerRow: rowBytes,
                            bytesPerImage: bgraBytes.count)
        }
        
        return result
    }

    private enum TextureSide {
        case Top
        case Bottom
        case Right
        case Left
        case Back
        case Front
    }
}
