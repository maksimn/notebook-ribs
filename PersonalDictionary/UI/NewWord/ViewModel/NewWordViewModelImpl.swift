//
//  NewWordViewModelImpl.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 29.10.2021.
//

class NewWordViewModelImpl: NewWordViewModel {

    unowned let view: NewWordView
    weak var interactor: NewWordInteractable?

    private static let empty = Lang(id: Lang.Id(raw: -1), name: "", shortName: "")

    init(view: NewWordView) {
        self.view = view
    }

    var text: String = "" {
        didSet {
            view.set(text: text)
        }
    }

    var allLangs: [Lang] = [] {
        didSet {
            view.set(allLangs: allLangs)
        }
    }

    var sourceLang: Lang = empty {
        didSet {
            view.set(sourceLang: sourceLang)
        }
    }

    var targetLang: Lang = empty {
        didSet {
            view.set(targetLang: targetLang)
        }
    }

    func save(sourceLang: Lang) {
        interactor?.save(sourceLang: sourceLang)
    }

    func save(targetLang: Lang) {
        interactor?.save(targetLang: targetLang)
    }

    func sendNewWord() {
        interactor?.sendNewWord()
    }

    func dismiss() {
        interactor?.dismiss()
    }
}
