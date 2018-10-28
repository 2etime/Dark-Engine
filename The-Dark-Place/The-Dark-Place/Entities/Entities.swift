
import MetalKit

class Entities {
    public static var CustomMeshes: CustomMeshLibrary!
    public static var CubeTextures: CubeTextureLibrary!

    public static func Initialize(){
        self.CustomMeshes = CustomMeshLibrary()
        self.CubeTextures = CubeTextureLibrary()
    }
    
}
