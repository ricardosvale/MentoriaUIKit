import UIKit

class PokemonListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        return tableView
    }()
    
    private var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
        loadPokemonList()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadPokemonList() {
        Task {
            do {
                let pokemonService = PokemonService()
                pokemons = try await pokemonService.fetchPokemonList()
               tableView.reloadData()
            } catch {
                print("Erro ao carregar a lista de Pokémons: \(error)")
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
     
        cell.configure(with: pokemons[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemons[indexPath.row]
 
        Task {
            do {
                let pokemonService = PokemonService()
                guard let url = selectedPokemon.pokemonUrl else { return }
                
                let pokemonDetail = try await pokemonService.fetchPokemonDetail(from: url)
                let detailVC = PokemonDetailViewController(pokemon: pokemonDetail)
                
                if let navigationController = self.navigationController {
                    navigationController.pushViewController(detailVC, animated: true)
                } else {
                    print("navigationController é nil. Não é possível navegar.")
                }
            } catch {
                print("Erro ao carregar os detalhes do Pokémon: \(error)")
            }
        }
    }
    
    // MARK: AJusta a altura da Celula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
}
