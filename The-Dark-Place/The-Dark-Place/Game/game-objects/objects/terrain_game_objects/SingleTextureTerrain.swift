
class SingleTextureTerrain: TerrainGameObject {
    
    init(_ textureType: TextureTypes){
        super.init(cellCount: 100, textureType: textureType)
        self.setScale(100)
    }
    
}
