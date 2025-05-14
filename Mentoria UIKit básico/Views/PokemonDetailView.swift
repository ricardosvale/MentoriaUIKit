import UIKit

class PokemonDetailView: UIView {

    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                pokemonImageView,
                nameLabel,
                heightLabel,
                weightLabel,
                typeLabel
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(stackView)
        
        // Ancoragem com Auto Layout
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            pokemonImageView.heightAnchor.constraint(equalToConstant: 150),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configure(with pokemonDetail: PokemonDetail) {
        nameLabel.text = pokemonDetail.name
        heightLabel.text = "altura \(pokemonDetail.height)"
        weightLabel.text = "peso \(pokemonDetail.weight)"
        
        let typesText = pokemonDetail.types.map { $0.getTitle() }.joined(separator: ", ")
        typeLabel.text = "tipo \(typesText)"
        
        pokemonImageView.image = UIImage(named: pokemonDetail.imageUrl)
    }
}
