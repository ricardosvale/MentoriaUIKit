import Foundation

final class PokemonService {
    
    let networkClient = NetworkClient()
    
    func fetchPokemonList() async throws -> [Pokemon] {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
        let response: PokemonListResponse = try await networkClient.fetch(from: urlString, decodeTo: PokemonListResponse.self)
        
        return response.results.map { $0.toDomainModel() }
    }
    
    func fetchPokemonDetail(from url: URL) async throws -> PokemonDetail {
        
        let response: PokemonDetailResponse = try await networkClient.fetch(from: url.absoluteString, decodeTo: PokemonDetailResponse.self)
        return response.toDomainModel()
    }
}
