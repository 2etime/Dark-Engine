
import MetalKit

class Entities {
    public static var Meshes: MeshLibrary!
    public static var Textures: TextureLibrary!
    public static var CubeTextures: CubeTextureLibrary!
    public static var Fonts: FontLibrary!
    public static var TextMeshes: TextMeshLibrary!
    
    
    public static func Initialize(){
        self.Meshes = MeshLibrary()
        self.Textures = TextureLibrary()
        self.CubeTextures = CubeTextureLibrary()
        self.Fonts = FontLibrary()
        self.TextMeshes = TextMeshLibrary()
    }
    
}
