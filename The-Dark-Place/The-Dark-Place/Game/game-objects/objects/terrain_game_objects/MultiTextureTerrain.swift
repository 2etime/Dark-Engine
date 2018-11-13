
class MultiTextureTerrain: TerrainGameObject {
    
    init(){
        super.init(cellCount: 100)
        self.setScale(100)
        self.setMultiTerrainTexture(MultiTerrainTexture(.Grass, .BlendMap, .Mud, .GrassFlowers, .Path))
    }
    
}
