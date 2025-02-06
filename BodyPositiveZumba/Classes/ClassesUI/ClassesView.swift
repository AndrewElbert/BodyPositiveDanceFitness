//
//  ClassesView.swift
//  Classes
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct ClassesView: View, ActionableView {

    enum Action {
        case toggleExpansion
    }

    var onAction: ((Action) -> Void)?
    @Environment(\.dismiss) var dismiss
    @Binding var viewState: ClassesViewState

    public init(
        viewState: Binding<ClassesViewState>,
        onAction: ((Action) -> Void)? = nil
    ) {
        self._viewState = viewState
        self.onAction = onAction
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack {
                    Text("Classes")
                        .font(.system(size: 33, weight: .bold, design: .serif))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.top, 40)
                        .padding(.bottom, 8)

                    Text("Explore Our Wide Range of Classes Below!")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundColor(.black.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 25)

                    SwipableCarouselComponent<AnyView, DanceClass>(
                        viewModel: SwipableCarouselViewModel(viewState: $viewState.carouselViewState)
                    ) { danceClass, isCurrentCard in
                        AnyView(
                            DanceClassCard(danceClass: danceClass)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(isCurrentCard ? danceClass.color : Color.clear,
                                                lineWidth: isCurrentCard ? 3 : 0)
                                )
                                .shadow(
                                    color: isCurrentCard ? danceClass.color.opacity(0.8) : Color.clear,
                                    radius: 40, x: 0, y: 0
                                )
                                .shadow(
                                    color: isCurrentCard ? danceClass.color.opacity(0.6) : Color.clear,
                                    radius: 50, x: 0, y: 0
                                )
                        )
                    }
                    .frame(height: 333)

                    Button(action: {
                        withAnimation(.easeInOut) {
                            onAction?(.toggleExpansion)
                        }
                    }) {
                        HStack(spacing: 4) {
                            Text(viewState.isBioExpanded ? "Show Less" : "Learn More About \(viewState.currentDanceClass.rawValue)!")
                                .font(.system(size: 16, weight: .semibold, design: .serif))
                            Image(systemName: viewState.isBioExpanded ? "chevron.up" : "chevron.down")
                        }
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                    }

                    if viewState.isBioExpanded {
                        Text(viewState.currentDanceClass.description)
                            .font(.system(size: 18, design: .serif))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    Button(action: {
                    }) {
                        Text("View All Classes")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .foregroundColor(.black)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 20)
                            .background(viewState.currentDanceClass.color.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.black, lineWidth: 3)
                            )
                            .cornerRadius(8)
                    }
                    .padding(.top, 50)
                }
                .padding(.bottom, 20)
            }

            CloseButton(dismiss: {
                dismiss()
            })
            .padding()
        }
    }
}

