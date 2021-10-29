//
//  NewWordBuilder.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 29.10.2021.
//

import RIBs

protocol NewWordDependency: Dependency {
    // Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class NewWordComponent: Component<NewWordDependency> {

    // Declare 'fileprivate' dependencies that are only used by this RIB.
    let langRepository = buildLangRepository()

    private static func buildLangRepository() -> LangRepository {
        let langData = buildLangData()

        return LangRepositoryImpl(userDefaults: UserDefaults.standard,
                                  data: langData)
    }

    private static func buildLangData() -> LangData {
        let lang1 = Lang(id: Lang.Id(raw: 1), name: NSLocalizedString("English", comment: ""), shortName: "EN")
        let lang2 = Lang(id: Lang.Id(raw: 2), name: NSLocalizedString("Russian", comment: ""), shortName: "RU")
        let lang3 = Lang(id: Lang.Id(raw: 3), name: NSLocalizedString("French", comment: ""), shortName: "FR")
        let lang4 = Lang(id: Lang.Id(raw: 4), name: NSLocalizedString("Italian", comment: ""), shortName: "IT")

        let langData = LangData(allLangs: [lang1, lang2, lang3, lang4],
                                sourceLangKey: "io.github.maksimn.pd.sourceLang",
                                targetLangKey: "io.github.maksimn.pd.targetLang",
                                defaultSourceLang: lang1,
                                defaultTargetLang: lang2)

        return langData
    }
}

// MARK: - Builder

protocol NewWordBuildable: Buildable {
    func build(withListener listener: NewWordListener) -> NewWordRouting
}

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

        interactor.viewModel = viewModel
        interactor.listener = listener

        return NewWordRouter(interactor: interactor, viewController: viewController)
    }
}
