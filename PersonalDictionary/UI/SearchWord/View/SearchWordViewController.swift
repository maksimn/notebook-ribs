//
//  SearchWordViewController.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 11.10.2021.
//

import UIKit

enum SearchWordMode {
    case bySourceWord, byTranslation
}

struct SearchWordViewStaticContent {
    let baseContent: WordListViewStaticContent
    let searchBarPlaceholderText: String
    let noWordsFoundText: String
    let searchByLabelText: String
    let sourceWordText: String
    let translationText: String
}

final class SearchWordViewController: WordListViewController, SearchWordView {

    let searchStaticContent: SearchWordViewStaticContent

    let wordsNotFoundLabel = UILabel()
    let searchByLabel = UILabel()
    var searchBySegmentedControl: UISegmentedControl?

    init(staticContent: SearchWordViewStaticContent, styles: WordListViewStyles) {
        self.searchStaticContent = staticContent
        super.init(params: WordListViewParams(staticContent: staticContent.baseContent, styles: styles))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rearrangeViews()
    }

    func setWordsNotFoundLabel(hidden: Bool) {
        wordsNotFoundLabel.isHidden = hidden
    }

    func set(_ searchMode: SearchWordMode) {
        switch searchMode {
        case .bySourceWord:
            searchBySegmentedControl?.selectedSegmentIndex = 0
        case .byTranslation:
            searchBySegmentedControl?.selectedSegmentIndex = 1
        }
    }

    @objc
    func onSearchByValueChanged() {
        guard let selectedIndex = searchBySegmentedControl?.selectedSegmentIndex else { return }

        switch selectedIndex {
        case 0:
            print("search by source word")
        case 1:
            print("search by translation")
        default:
            break
        }
    }
}

extension SearchWordViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            print("search text \(searchText)")
        }
    }
}
