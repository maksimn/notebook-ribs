//
//  NewWordBuilder.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 29.10.2021.
//

import RIBs

final class NewWordBuilder: Builder<NewWordDependency>, NewWordBuildable {

    override init(dependency: NewWordDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: NewWordListener) -> NewWordRouting {
        let staticContent = NewWordViewStaticContent(
            selectButtonTitle: NSLocalizedString("Select", comment: ""),
            arrowText: NSLocalizedString("⇋", comment: ""),
            okText: NSLocalizedString("OK", comment: ""),
            textFieldPlaceholder: NSLocalizedString("Enter a new word", comment: "")
        )
        let styles = NewWordViewStyles(backgroundColor: appBackgroundColor)

        let component = NewWordComponent(dependency: dependency)

        let viewController = NewWordViewController(staticContent: staticContent, styles: styles)

        let viewModel = NewWordViewModelImpl(view: viewController)

        viewController.viewModel = viewModel

        let interactor = NewWordInteractor(viewModel: viewModel,
                                           langRepository: component.langRepository)

        viewModel.interactor = interactor
        interactor.listener = listener

        return NewWordRouter(interactor: interactor, viewController: viewController)
    }
}
