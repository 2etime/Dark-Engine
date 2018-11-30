import MetalKit

class FontCharacter {
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
        let properXPos: Float = (2 * xPos) - 1
        let properYPos: Float = yPos - 0.7
        let properMaxXPos: Float = (2 * maxXPos) - 1
        let properMaxYPos: Float = (2 * maxYPos) - 1
        
        let xTex: Float = xTextureCoord
        let yTex: Float = yTextureCoord
        let maxXTex: Float = xMaxTextureCoord
        let maxYTex: Float = yMaxTextureCoord
        
        let position1 = float3(properXPos, properYPos, 0)
        let textureCoord1 = float2(xTex, yTex)
        let vertex1 = Vertex(position: position1, normal: float3(0), textureCoordinate: textureCoord1)
        
        let position2 = float3(properXPos, properMaxYPos, 0)
        let textureCoord2 = float2(xTex, maxYTex)
        let vertex2 = Vertex(position: position2, normal: float3(0), textureCoordinate: textureCoord2)
        
        let position3 = float3(properMaxXPos, properMaxYPos, 0)
        let textureCoord3 = float2(maxXTex, maxYTex)
        let vertex3 = Vertex(position: position3, normal: float3(0), textureCoordinate: textureCoord3)

        let position4 = float3(properMaxXPos, properMaxYPos, 0)
        let textureCoord4 = float2(maxXTex, maxYTex)
        let vertex4 = Vertex(position: position4, normal: float3(0), textureCoordinate: textureCoord4)
        
        let position5 = float3(properMaxXPos, properYPos, 0)
        let textureCoord5 = float2(maxXTex, yTex)
        let vertex5 = Vertex(position: position5, normal: float3(0), textureCoordinate: textureCoord5)

        let position6 = float3(properXPos, properYPos, 0)
        let textureCoord6 = float2(xTex, yTex)
        let vertex6 = Vertex(position: position6, normal: float3(0), textureCoordinate: textureCoord6)

        vertices.append(contentsOf: [vertex1, vertex2, vertex3, vertex4, vertex5, vertex6])
    }
    
    
}

