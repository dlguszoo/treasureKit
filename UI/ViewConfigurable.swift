protocol ViewConfigurable {
    func setupView()
    func addComponents()
    func setupConstraints()
    associatedtype DataType
    func configure(with data: DataType)
}

