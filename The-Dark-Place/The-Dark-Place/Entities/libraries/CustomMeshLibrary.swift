
import MetalKit

enum CustomMeshTypes {
    case Triangle
    case Cube
    case Quad
}

class CustomMeshLibrary: Library<CustomMeshTypes, CustomMesh> {

    private var library: [CustomMeshTypes : CustomMesh] = [:]
    
    override func fillLibrary() {
        library.updateValue(Triangle_CustomMesh(), forKey: .Triangle)
        library.updateValue(Cube_CustomMesh(), forKey: .Cube)
        library.updateValue(Quad_CustomMesh(), forKey: .Quad)
    }
    
    override subscript(_ type: CustomMeshTypes) -> CustomMesh {
        return (library[type])!
    }
    
}




