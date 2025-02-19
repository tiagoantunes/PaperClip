//
//  LoadingView.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView {
            Text(Strings.progressViewLabel)
        }
        .scaleEffect(1.2)
        //.tint(.accent)
        //.foregroundColor(.accent)
    }
}

#Preview {
    LoadingView()
}
