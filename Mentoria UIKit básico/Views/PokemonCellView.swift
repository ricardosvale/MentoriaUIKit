import UIKit

class PokemonCellView: UIView {

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

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                pokemonImageView,
                nameLabel,
                numberLabel
            ]
        )
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.addSubview(verticalStackView)
        backgroundColor = .white
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 100),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    public func configure(with pokemon: Pokemon) {
        pokemonImageView.image = UIImage(named: pokemon.pokemonImage)
        nameLabel.text = pokemon.name
        numberLabel.text = "#\(pokemon.number)"
    }
}
