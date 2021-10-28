//
//  WordListComponent.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

protocol WordListDependency: Dependency {
    // Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class WordListComponent: Component<EmptyDependency>, WordListDependency {
    // Declare 'fileprivate' dependencies that are only used by this RIB.
    init() {
        super.init(dependency: EmptyComponent())
    }

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

    var wordListRepository: WordListRepository {
        buildWordListRepository()
    }

    var translationService: TranslationService {
        buildTranslationService()
    }

    private func buildTranslationService() -> TranslationService {
        let ponsApiData = PonsApiData(url: "https://api.pons.com/v1/dictionary",
                                      secretHeaderKey: "X-Secret",
                                      secret: "")

        return PonsTranslationService(apiData: ponsApiData,
                                      coreService: UrlSessionCoreService(),
                                      jsonCoder: JSONCoderImpl(),
                                      logger: buildLogger())
    }

    private func buildLogger() -> Logger {
        SimpleLogger()
    }

    private func buildWordListRepository() -> WordListRepository {
        let coreWordListRepositoryArgs = CoreWordListRepositoryArgs(persistentContainerName: "StorageModel")

        return CoreWordListRepository(args: coreWordListRepositoryArgs,
                                      langRepository: WordListComponent.langRepository,
                                      logger: buildLogger())
    }

    private static let langRepository = buildLangRepository()

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
