//
//  GlobalSearchbarView.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import SwiftUI

public struct GlobalSearchbarView: View {
    var placeholderText = "Search"
    var enableFocus: Bool = true
    var hideCancel: Bool = false
    var showCloseButton: Bool = false
    
    var cancelAction : (() -> Void)?
    @Binding var text: String

    @FocusState private var textfieldFocus: Bool
    var cancelTitle: String
    
    // MARK: initialization
    public init(text: Binding<String>,
                placeholderText: String = "Search",
                cancelTitle: String = "Cancel",
                enableFocus: Bool = true,
                hideCancel: Bool = false,
                showCloseButton: Bool = false,
                cancelAction: (() -> Void)? = nil) {
        self._text = text
        self.placeholderText = placeholderText
        self.cancelTitle = cancelTitle
        self.cancelAction = cancelAction
        self.enableFocus = enableFocus
        self.hideCancel = hideCancel
        self.showCloseButton = showCloseButton
    }
    
    // MARK: body
    public var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                TextField(placeholderText, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.system(size: 14))
                    .padding(EdgeInsets(top: 12, leading: 44, bottom: 12, trailing: 12))
                    .background(Color.cloudNormal)
                    .cornerRadius(6)
                    .focused($textfieldFocus)
                    .multilineTextAlignment(.leading)
              
                Image(.icSearch)
                    .frame(width: 24, height: 24, alignment: .leading)
                    .foregroundColor(.secondary)
                    .padding(.leading, 12)
            }
            Spacer().frame(width: 10)
            if hideCancel && !text.isEmpty && !showCloseButton {
                cancelButton
            } else if !hideCancel, !showCloseButton {
                cancelButton
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                if enableFocus {
                    textfieldFocus = true
                }
            }
        }
    }
    
    fileprivate var cancelButton: some View {
        Button {
            cancelAction?()
        } label: {
            Text("Cancel")
                .foregroundStyle(Color.blue)
                .font(.system(size: .normal, weight: .regular))
        }
        .fixedSize()
    }
}

struct ZSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        GlobalSearchbarView(text: .constant(""), cancelAction: {})
    }
}
