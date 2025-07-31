//
//  UIStackView+Ex.swift
//  IrregularVerb
//
//  Created by Кристина Олейник on 31.07.2025.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
