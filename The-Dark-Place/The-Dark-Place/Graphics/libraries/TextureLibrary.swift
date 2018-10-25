import MetalKit

enum TextureTypes {
    case ShadowMap
    case NormalShadowGBuffer
    case AlbedoSpecularGBuffer
    case DepthGBuffer
}

class TextureLibrary: Library<TextureTypes, MTLTexture> {
    private var library: [TextureTypes : Texture] = [:]
    
    override func fillLibrary() {
        library.updateValue(ShadowMap_Texture(), forKey: .ShadowMap)
        library.updateValue(NormalShadow_Texture(), forKey: .NormalShadowGBuffer)
        library.updateValue(AlbedoSpecular_Texture(), forKey: .AlbedoSpecularGBuffer)
        library.updateValue(Depth_Texture(), forKey: .DepthGBuffer)
    }
    
    override subscript(_ type: TextureTypes) -> MTLTexture {
        return (library[type]?.texture)!
    }
}

protocol Texture {
    var name: String { get }
    var texture: MTLTexture! { get }
}

private class ShadowMap_Texture: Texture {
    var name: String = "Shadow Map Texture"
    var texture: MTLTexture!
    
    init() {
        let shadowTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .depth32Float,
                                                                               width: 2048,
                                                                               height: 2048,
                                                                               mipmapped: false)
        shadowTextureDescriptor.resourceOptions = .storageModePrivate
        shadowTextureDescriptor.usage = [.renderTarget, .shaderRead]
        texture = DarkEngine.Device.makeTexture(descriptor: shadowTextureDescriptor)
        texture.label = name
    }
}

private class NormalShadow_Texture: Texture {
    var name: String = "Normal + Specular GBuffer"
    var texture: MTLTexture!
    
    init() {
        let textureDesc = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .rgba8Snorm,
                                                     width: Int(GameView.Width),
                                                     height: Int(GameView.Height),
                                                     mipmapped: false)
        textureDesc.textureType = .type2D
        textureDesc.usage = .renderTarget
        textureDesc.storageMode = .managed
        texture = DarkEngine.Device.makeTexture(descriptor: textureDesc)
        texture.label = name
    }
}

private class AlbedoSpecular_Texture: Texture {
    var name: String = "Albedo + Shadow GBuffer"
    var texture: MTLTexture!
    
    init() {
        let textureDesc = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .rgba8Unorm_srgb,
                                                     width: Int(GameView.Width),
                                                     height: Int(GameView.Height),
                                                     mipmapped: false)
        textureDesc.textureType = .type2D
        textureDesc.usage = .renderTarget
        textureDesc.storageMode = .managed
        texture = DarkEngine.Device.makeTexture(descriptor: textureDesc)
        texture.label = name
    }
}

private class Depth_Texture: Texture {
    var name: String = "Depth GBuffer"
    var texture: MTLTexture!
    
    init() {
        let textureDesc = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .r32Float,
                                                     width: Int(GameView.Width),
                                                     height: Int(GameView.Height),
                                                     mipmapped: false)
        textureDesc.textureType = .type2D
        textureDesc.usage = .renderTarget
        textureDesc.storageMode = .managed
        texture = DarkEngine.Device.makeTexture(descriptor: textureDesc)
        texture.label = name
    }
}
