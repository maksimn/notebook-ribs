//
//  NewWordInteractor.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 29.10.2021.
//

import RIBs

protocol NewWordListener: AnyObject {
    // Declare methods the interactor can invoke to communicate with other RIBs.
    func addNewWord(_ wordItem: WordItem)

    func dismissNewWord()
}

final class NewWordInteractor: PresentableInteractor<NewWordViewModel>, NewWordInteractable {

    weak var listener: NewWordListener?

    weak var viewModel: NewWordViewModel?

    private var langRepository: LangRepository

    private(set) var allLangs: [Lang] = [] {
        didSet {
            viewModel?.allLangs = allLangs
        }
    }

    private(set) var sourceLang: Lang = empty {
        didSet {
            viewModel?.sourceLang = sourceLang
        }
    }

    private(set) var targetLang: Lang = empty {
        didSet {
            viewModel?.targetLang = targetLang
        }
    }

    private static let empty = Lang(id: Lang.Id(raw: -1), name: "", shortName: "")

    init(viewModel: NewWordViewModel, langRepository: LangRepository) {
        self.langRepository = langRepository
        self.viewModel = viewModel
        super.init(presenter: viewModel)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        fetchData()
    }

    func save(sourceLang: Lang) {
        langRepository.sourceLang = sourceLang
        self.sourceLang = sourceLang
    }

    func save(targetLang: Lang) {
        langRepository.targetLang = targetLang
        self.targetLang = targetLang
    }

    func sendNewWord() {
        guard let text = viewModel?.text.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty,
              let sourceLang = viewModel?.sourceLang,
              let targetLang = viewModel?.targetLang else {
            return
        }
        let wordItem = WordItem(text: text, sourceLang: sourceLang, targetLang: targetLang)

        listener?.addNewWord(wordItem)
    }

    func dismiss() {
        listener?.dismissNewWord()
    }

    private func fetchData() {
        allLangs = langRepository.allLangs
        sourceLang = langRepository.sourceLang
        targetLang = langRepository.targetLang
    }
}
