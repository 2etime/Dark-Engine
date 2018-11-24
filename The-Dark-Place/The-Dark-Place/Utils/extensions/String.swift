
extension String {
    
    func split(_ character: String)->[String]{
        return self.split(separator: Character(character)).map { String($0) }
    }
    
}
