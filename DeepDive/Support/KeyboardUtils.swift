//
//  KeyboardUtils.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/18/23.
//

import UIKit

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

