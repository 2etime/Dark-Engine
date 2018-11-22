import MetalKit

class World {
    
    private static var _currentId: Int = 0
    private static var _objects: [Int :Node] = [:]
    
    public static func addObject(_ object: Node)->Int{
        self._objects.updateValue(object, forKey: _currentId)
        self._objects[_currentId]?.setID(_currentId)
        self._currentId += 1
        return self._currentId - 1
    }
    
    public static func updateObjectPosition(id: Int, position: float3){
        self._objects[id]?.setPosition(position)
    }

    public static func checkWorldCollisions(){
        for i in 0..<_objects.count {
            let object1 = _objects[i]
            for j in 0..<_objects.count {
                let object2 = _objects[j]
                print(object2?.getPosition())
            }
        }
    }
}
