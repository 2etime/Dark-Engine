import MetalKit

class CharacterMesh {
    var id: Int!
    var xTextureCoord: Float!
    var yTextureCoord: Float!
    var xMaxTextureCoord: Float!
    var yMaxTextureCoord: Float!
    var xOffset: Float!
    var yOffset: Float!
    var sizeX: Float!
    var sizeY: Float!
    var xAdvance: Float!
    var vertices: [Vertex] = []
    
    init(id: Int,
         xTextureCoord: Float, yTextureCoord: Float,
         xTextureSize: Float, yTextureSize: Float,
         xOffset: Float, yOffset: Float,
         sizeX: Float, sizeY: Float,
         xAdvance: Float) {
        self.id = id
        self.xTextureCoord = xTextureCoord
        self.yTextureCoord = yTextureCoord
        self.xOffset = xOffset
        self.yOffset = yOffset
        self.sizeX = sizeX
        self.sizeY = sizeY
        self.xMaxTextureCoord = xTextureSize + xTextureCoord
        self.yMaxTextureCoord = yTextureSize + yTextureCoord
        self.xAdvance = xAdvance
    }
    
    func generateVertices(cursor: float2, fontSize: Float) {
        let xPos: Float = cursor.x + (xOffset * fontSize)
        let yPos: Float = cursor.y + (yOffset * fontSize)
        let maxXPos: Float = xPos + (sizeX * fontSize)
        let maxYPos: Float = yPos + (sizeY * fontSize)
        
        let xTex: Float = xTextureCoord
        let yTex: Float = yTextureCoord
        let maxXTex: Float = xMaxTextureCoord
        let maxYTex: Float = yMaxTextureCoord
        
        let position1 = float3(xPos, yPos, 0)
        let textureCoord1 = float2(xTex, maxYTex)
        let vertex1 = Vertex(position: position1, normal: float3(0), textureCoordinate: textureCoord1)
        
        let position2 = float3(xPos, maxYPos, 0)
        let textureCoord2 = float2(xTex, yTex)
        let vertex2 = Vertex(position: position2, normal: float3(0), textureCoordinate: textureCoord2)
        
        let position3 = float3(maxXPos, maxYPos, 0)
        let textureCoord3 = float2(maxXTex, yTex)
        let vertex3 = Vertex(position: position3, normal: float3(0), textureCoordinate: textureCoord3)
        
        let position4 = float3(maxXPos, maxYPos, 0)
        let textureCoord4 = float2(maxXTex, yTex)
        let vertex4 = Vertex(position: position4, normal: float3(0), textureCoordinate: textureCoord4)
        
        let position5 = float3(xPos, yPos, 0)
        let textureCoord5 = float2(xTex, maxYTex)
        let vertex5 = Vertex(position: position5, normal: float3(0), textureCoordinate: textureCoord5)
        
        let position6 = float3(maxXPos, yPos, 0)
        let textureCoord6 = float2(maxXTex, maxYTex)
        let vertex6 = Vertex(position: position6, normal: float3(0), textureCoordinate: textureCoord6)
        
        vertices.append(contentsOf: [vertex1, vertex2, vertex3, vertex4, vertex5, vertex6])
    }
    
    
}

