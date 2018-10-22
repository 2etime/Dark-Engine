
import MetalKit

enum CustomMeshTypes {
    case Triangle
    case Cube
}

class CustomMeshLibrary: Library<CustomMeshTypes, CustomMesh> {

    private var library: [CustomMeshTypes : CustomMesh] = [:]
    
    override func fillLibrary() {
        library.updateValue(Triangle_CustomMesh(), forKey: .Triangle)
        library.updateValue(Cube_CustomMesh(), forKey: .Cube)
    }
    
    override subscript(_ type: CustomMeshTypes) -> CustomMesh {
        return (library[type])!
    }
    
}




