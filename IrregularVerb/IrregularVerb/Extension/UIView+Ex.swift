//
//  UIView+Ex.swift
//  IrregularVerb
//
//  Created by Кристина Олейник on 31.07.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
