import UIKit
import SwiftUI


class BabyMealDetailViewController: UIViewController {
    private let viewModel: BabyMealDetailViewModel
    private let scrollView = UIScrollView()
    
    private func color(named: String) -> UIColor {
        return UIColor(named: named) ?? .systemBackground
    }
    private let contentView = UIView()
    private let emojiLabel = EmojiUILabel()
    private let allergensView = AllergensUIView()
    private let reactionsView = ReactionsUIView()
    private let recipeInfoLabel = BulletListUILabel()
    private let ingredientsLabel = BulletListUILabel()
    private let cookingInstructionsLabel = NumberedListUILabel()
    private var logReactionHostingController: SwiftUIButtonController?
    private var saveToCollectionsHostingController: SwiftUIButtonController?
    private let recipeInfoHeader = HeaderUIView(icon: UIImage(systemName: "info.square"), title: "Recipe Information", color: .label)
    private let ingredientsHeader = HeaderUIView(icon: UIImage(systemName: "note.text"), title: "Ingredients", color: .label)
    private let cookingInstructionsHeader = HeaderUIView(icon: UIImage(systemName: "frying.pan"), title: "Cooking Instructions", color: .label)
    
    private var babyMeal: BabyMeal
    
    init(babyMeal: BabyMeal) {
        self.viewModel = BabyMealDetailViewModel(
            saveBabyMealUseCase: SaveBabyMealUseCase(repo: BabyMealRepositoryImpl.shared),
            deleteBabyMealUseCase: DeleteBabyMealUseCase(repo: BabyMealRepositoryImpl.shared),
            getBabyMealUseCase: GetBabymealUseCase(repo: BabyMealRepositoryImpl.shared)
        )
        self.babyMeal = babyMeal
        super.init(nibName: nil, bundle: nil)
        self.title = babyMeal.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        self.babyMeal = viewModel.getBabyMeal(babyMeal: babyMeal)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupUI() {
        setupScrollView()
        setupEmojiLabel()
        setupAllergensView()
        setupReactionsView()
        setupRecipeInfoHeader()
        setupRecipeInfoLabel()
        setupIngredientsHeader()
        setupIngredientsLabel()
        setupCookingInstructionsHeader()
        setupCookingInstructionsLabel()
        setupButtons()
    }
    
    private func setupReactionsView() {
        if !areReactionsEmpty() {
            contentView.addSubview(reactionsView)
            reactionsView.translatesAutoresizingMaskIntoConstraints = false
            reactionsView.setReactions(babyMeal.reactionList)
            
            NSLayoutConstraint.activate([
                reactionsView.topAnchor.constraint(equalTo: allergensView.bottomAnchor, constant: 16),
                reactionsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                reactionsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])
        }
    }
    
    private func areReactionsEmpty() -> Bool {
        return babyMeal.reactionList.isEmpty
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupEmojiLabel() {
        contentView.addSubview(emojiLabel)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.text = babyMeal.emoji
        
        NSLayoutConstraint.activate([
            emojiLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.widthAnchor.constraint(equalToConstant: 100),
            emojiLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupAllergensView() {
        contentView.addSubview(allergensView)
        allergensView.translatesAutoresizingMaskIntoConstraints = false
        allergensView.setAllergens(babyMeal.allergens)
        
        setupHorizontalConstraints(for: allergensView, topAnchor: emojiLabel.bottomAnchor, topConstant: 16)
    }
    
    private func setupRecipeInfoHeader() {
        contentView.addSubview(recipeInfoHeader)
        recipeInfoHeader.translatesAutoresizingMaskIntoConstraints = false
        
        if areReactionsEmpty() {
            setupHorizontalConstraints(for: recipeInfoHeader, topAnchor: allergensView.bottomAnchor, topConstant: 24)
        } else {
            setupHorizontalConstraints(for: recipeInfoHeader, topAnchor: reactionsView.bottomAnchor, topConstant: 24)
        }
    }
    
    private func setupRecipeInfoLabel() {
        contentView.addSubview(recipeInfoLabel)
        recipeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        let recipeInfoItems = [
            "Serving size: \(babyMeal.servingSize)",
            "Estimated cooking time: \(babyMeal.estimatedCookingTimeMinutes) mins"
        ]
        recipeInfoLabel.setItems(recipeInfoItems)
        
        setupHorizontalConstraints(for: recipeInfoLabel, topAnchor: recipeInfoHeader.bottomAnchor, topConstant: 8, leadingConstant: 24)
    }
    
    private func setupIngredientsHeader() {
        contentView.addSubview(ingredientsHeader)
        ingredientsHeader.translatesAutoresizingMaskIntoConstraints = false
        
        setupHorizontalConstraints(for: ingredientsHeader, topAnchor: recipeInfoLabel.bottomAnchor, topConstant: 24)
    }
    
    private func setupIngredientsLabel() {
        contentView.addSubview(ingredientsLabel)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.setItems(babyMeal.ingredients)
        
        setupHorizontalConstraints(for: ingredientsLabel, topAnchor: ingredientsHeader.bottomAnchor, topConstant: 8, leadingConstant: 24)
    }
    
    private func setupCookingInstructionsHeader() {
        contentView.addSubview(cookingInstructionsHeader)
        cookingInstructionsHeader.translatesAutoresizingMaskIntoConstraints = false
        
        setupHorizontalConstraints(for: cookingInstructionsHeader, topAnchor: ingredientsLabel.bottomAnchor, topConstant: 24)
    }
    
    private func setupCookingInstructionsLabel() {
        contentView.addSubview(cookingInstructionsLabel)
        cookingInstructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        cookingInstructionsLabel.setItems(babyMeal.cookingSteps.components(separatedBy: "\n"))
        
        setupHorizontalConstraints(for: cookingInstructionsLabel, topAnchor: cookingInstructionsHeader.bottomAnchor, topConstant: 8, leadingConstant: 24)
    }
    
    private func setupButtons() {
        let saveToCollectionsButton = AnyView(
            MealDetailSaveToCollectionsButton(babyMeal: babyMeal)
        )

        saveToCollectionsHostingController = SwiftUIButtonController(rootView: saveToCollectionsButton)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if let saveToCollectionsView = saveToCollectionsHostingController?.view {
            if babyMeal.isAddedToCollections {
                let logReactionButton = AnyView(LogReactionButton(babyMeal: babyMeal))
                logReactionHostingController = SwiftUIButtonController(rootView: logReactionButton)
                
                if let logReactionView = logReactionHostingController?.view {
                    stackView.addArrangedSubview(logReactionView)
                    
                    logReactionHostingController?.onHeightChange = { [weak self] height in
                        logReactionView.heightAnchor.constraint(equalToConstant: height).isActive = true
                        self?.view.layoutIfNeeded()
                    }
                    
                    addChild(logReactionHostingController!)
                    logReactionHostingController?.didMove(toParent: self)
                }
            }
            
            stackView.addArrangedSubview(saveToCollectionsView)
            
            contentView.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: cookingInstructionsLabel.bottomAnchor, constant: 16),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
            
            saveToCollectionsHostingController?.onHeightChange = { [weak self] height in
                saveToCollectionsView.heightAnchor.constraint(equalToConstant: height).isActive = true
                self?.view.layoutIfNeeded()
            }
        }
        
        addChild(saveToCollectionsHostingController!)
        saveToCollectionsHostingController?.didMove(toParent: self)
    }
    
    private func setupHorizontalConstraints(for view: UIView, topAnchor: NSLayoutYAxisAnchor, topConstant: CGFloat, leadingConstant: CGFloat = 16, trailingConstant: CGFloat = -16, bottomAnchor: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat = 0) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConstant),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConstant)
        ])
        
        if let bottomAnchor = bottomAnchor {
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant).isActive = true
        }
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

#Preview {
    BabyMealDetailVCRepresentable()
        .modelContainer(ModelContextManager.createModelContainer())
}
