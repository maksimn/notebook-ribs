//
//  WordListComponent.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

// Declare 'fileprivate' dependencies that are only used by this RIB.
final class WordListComponent: Component<EmptyDependency> {

    let viewParams: WordListViewParams

    lazy private(set) var wordListRepository: WordListRepository = { buildWordListRepository() }()

    lazy private(set) var translationService: TranslationService = { buildTranslationService() }()

    lazy private(set) var langRepository: LangRepository = { buildLangRepository() }()

    init(globalSettings: PDGlobalSettings) {
        self.globalSettings = globalSettings

        viewParams = WordListViewParams(
            staticContent: WordListViewStaticContent(
                newWordButtonImage: UIImage(named: "icon-plus")!,
                deleteAction: DeleteActionStaticContent(
                    image: UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))!
                )
            ),
            styles: WordListViewStyles(
                backgroundColor: globalSettings.appBackgroundColor,
                deleteAction: DeleteActionStyles(
                    backgroundColor: UIColor(red: 1, green: 0.271, blue: 0.227, alpha: 1)
                )
            )
        )

        super.init(dependency: EmptyComponent())
    }

    // MARK: - private

    private let globalSettings: PDGlobalSettings

    private func buildTranslationService() -> TranslationService {
        let ponsApiData = PonsApiData(url: "https://api.pons.com/v1/dictionary",
                                      secretHeaderKey: "X-Secret",
                                      secret: globalSettings.ponsApiSecret)

        return PonsTranslationService(apiData: ponsApiData,
                                      coreService: UrlSessionCoreService(),
                                      jsonCoder: JSONCoderImpl(),
                                      logger: buildLogger())
    }

    private func buildLogger() -> Logger {
        SimpleLogger(isLoggingEnabled: globalSettings.isLoggingEnabled)
    }

    private func buildWordListRepository() -> WordListRepository {
        let coreWordListRepositoryArgs = CoreWordListRepositoryArgs(persistentContainerName: "StorageModel")

        return CoreWordListRepository(args: coreWordListRepositoryArgs,
                                      langRepository: langRepository,
                                      logger: buildLogger())
    }

    private func buildLangRepository() -> LangRepository {
        LangRepositoryImpl(userDefaults: UserDefaults.standard,
                           data: globalSettings.langData)
    }
}
