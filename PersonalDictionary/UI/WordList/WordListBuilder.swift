//
//  WordListBuilder.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

protocol WordListDependency: Dependency {
    // Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class WordListComponent: Component<WordListDependency> {
    // Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol WordListBuildable: Buildable {
    func build(withListener listener: WordListListener) -> WordListRouting
}

final class WordListBuilder: Builder<WordListDependency>, WordListBuildable {

    override init(dependency: WordListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: WordListListener) -> WordListRouting {
        let staticContent = WordListViewStaticContent(
                newWordButtonImage: UIImage(named: "icon-plus")!,
                deleteAction: DeleteActionStaticContent(
                    image: UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))!
                )
            )

            let styles = WordListViewStyles(
                backgroundColor: appBackgroundColor,
                deleteAction: DeleteActionStyles(
                    backgroundColor: UIColor(red: 1, green: 0.271, blue: 0.227, alpha: 1)
                )
            )

        _ = WordListComponent(dependency: dependency)
        let viewController = WordListViewController(staticContent: staticContent, styles: styles)
        let interactor = WordListInteractor(presenter: viewController)
        interactor.listener = listener
        return WordListRouter(interactor: interactor, viewController: viewController)
    }
}