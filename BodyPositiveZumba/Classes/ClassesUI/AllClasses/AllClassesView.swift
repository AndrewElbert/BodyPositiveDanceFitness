//
//  AllClassesView.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/12/25.
//

import SwiftUI

struct AllClassesView: View {
    @StateObject private var viewModel = AllClassesViewModel()
    
    var body: some View {
        List(viewModel.viewState.classes) { danceClass in
            HStack {
                Text(danceClass.rawValue)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    viewModel.bookClass(danceClass)
                }) {
                    Text("Book")
                        .font(.system(.subheadline, design: .rounded, weight: .bold))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .foregroundColor(danceClass.color)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .listRowBackground(
                danceClass.color
                    .opacity(0.9)
            )
        }
        .listStyle(.plain)
        .navigationTitle("Dance Classes")
    }
}
