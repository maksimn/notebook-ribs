//
//  NewWordViewUIK.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.09.2021.
//

import UIKit

struct NewWordViewStaticContent {
    let selectButtonTitle: String
    let arrowText: String
    let okText: String
    let textFieldPlaceholder: String
}

struct NewWordViewStyles {
    let backgroundColor: UIColor
}

typealias NewWordViewParams = ViewParams<NewWordViewStaticContent, NewWordViewStyles>

class NewWordViewController: UIViewController, NewWordView, NewWordViewControllable, UITextFieldDelegate {

    weak var viewModel: NewWordViewModel?

    let params: NewWordViewParams

    let contentView = UIView()
    let sourceLangLabel = UILabel()
    let targetLangLabel = UILabel()
    let arrowLabel = UILabel()
    let okButton = UIButton()
    let textField = UITextField()
    var langPickerPopup: LangPickerPopup?

    private var isSelectingSourceLang: Bool = false

    init(params: NewWordViewParams) {
        self.params = params
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    func set(text: String) {
        textField.text = text
    }

    func set(allLangs: [Lang]) {
        releaseLangPickerPopup()

        langPickerPopup = LangPickerPopup(langPickerController: LangPickerController(langs: allLangs),
                                          onSelectLang: { [weak self] lang in
                                            self?.onSelectLang(lang)
                                          },
                                          selectButtonTitle: params.staticContent.selectButtonTitle,
                                          backgroundColor: params.styles.backgroundColor,
                                          isHidden: true)

        layoutLangPickerPopup()
    }

    func set(sourceLang: Lang) {
        sourceLangLabel.text = sourceLang.name
    }

    func set(targetLang: Lang) {
        targetLangLabel.text = targetLang.name
    }

    // MARK: - User Action Handlers

    @objc
    func onSourceLangLabelTap() {
        isSelectingSourceLang = true
        langPickerPopup?.isHidden = false
    }

    @objc
    func onTargetLangLabelTap() {
        isSelectingSourceLang = false
        langPickerPopup?.isHidden = false
    }

    @objc
    func onOkButtonTap() {
        sendNewWordAndDismiss()
    }

    func onSelectLang(_ lang: Lang) {
        langPickerPopup?.isHidden = true

        if isSelectingSourceLang {
            viewModel?.sourceLang = lang
        } else {
            viewModel?.targetLang = lang
        }
    }

    // MARK: - UITextFieldDelegate

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        viewModel?.text = textField.text ?? ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendNewWordAndDismiss()
        return true
    }

    // MARK: - private

    private func sendNewWordAndDismiss() {
        viewModel?.sendNewWord()
        viewModel?.dismiss()
    }
}
