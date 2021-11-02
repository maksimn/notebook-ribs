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
        let component = NewWordComponent(dependency: dependency)

        let viewController = NewWordViewController(staticContent: component.staticContent,
                                                   styles: component.styles)

        let viewModel = NewWordViewModelImpl(view: viewController)

        viewController.viewModel = viewModel

        let interactor = NewWordInteractor(viewModel: viewModel,
                                           langRepository: component.langRepository)

        viewModel.interactor = interactor
        interactor.listener = listener

        return NewWordRouter(interactor: interactor, viewController: viewController)
    }
}
