
import MetalKit

enum CustomMeshTypes {
    case Triangle
}

class CustomMeshLibrary: Library<CustomMeshTypes, CustomMesh> {

    private var library: [CustomMeshTypes : CustomMesh] = [:]
    
    override func fillLibrary() {
        library.updateValue(Triangle_CustomMesh(), forKey: .Triangle)
    }
    
    override subscript(_ type: CustomMeshTypes) -> CustomMesh {
        return (library[type])!
    }
    
}




