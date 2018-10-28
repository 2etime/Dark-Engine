
import MetalKit

class Entities {
    public static var Meshes: MeshLibrary!
    public static var CubeTextures: CubeTextureLibrary!

    public static func Initialize(){
        self.Meshes = MeshLibrary()
        self.CubeTextures = CubeTextureLibrary()
    }
    
}
