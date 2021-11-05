//
//  WordListViewParams.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 06.11.2021.
//

import UIKit

typealias WordListViewParams = ViewParams<WordListViewStaticContent, WordListViewStyles>

struct WordListViewStaticContent {
    let newWordButtonImage: UIImage
    let deleteAction: DeleteActionStaticContent
}

struct WordListViewStyles {
    let backgroundColor: UIColor
    let deleteAction: DeleteActionStyles
}
