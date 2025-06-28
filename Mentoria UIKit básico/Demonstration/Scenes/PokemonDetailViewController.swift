import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let pokemonDetailView = PokemonDetailView()
    private let pokemon: PokemonDetail
    
    init(pokemon: PokemonDetail) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = pokemonDetailView
        navigationController?.navigationBar.tintColor = .black
        pokemonDetailView.configure(with: pokemon)
        setBackgroundColor(for: pokemon)
        
    }
    private func setBackgroundColor(for pokemon: PokemonDetail) {
        guard let type = pokemon.types.first else { return }
        view.backgroundColor = type.getColor()
    }
}
