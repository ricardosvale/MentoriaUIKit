import Foundation

// Enum para erros de serviço
enum ServiceError: Error {
    case invalidURL
    case emptyData
    case decodingError
}

class NetworkClient {
    
    // Função assíncrona para buscar dados da URL e fazer o decode de um tipo genérico
    func fetch<T: Decodable>(from urlString: String, decodeTo type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw ServiceError.invalidURL
        }
        
        do {
            // Usando a versão assíncrona de URLSession
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decodificando os dados em um objeto do tipo genérico T
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            // Lançando erro caso a requisição ou o decode falhe
            throw ServiceError.decodingError
        }
    }
}
