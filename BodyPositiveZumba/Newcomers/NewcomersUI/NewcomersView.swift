//
//  NewcomersView.swift
//  NewcomersUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct FAQView: View {
    @Environment(\.dismiss) var dismiss // Access the dismiss environment value
    @State private var expandedQuestions: Set<Int> = []
    @State private var closingIndex: Int? = nil

    let faqItems: [(question: String, answer: String)] = [
        ("Do I need dance experience?", "No! We welcome anyone and everyone who has a desire to move their body!"),
        ("What should I wear?", "Most people wear comfortable workout clothes. And please, no street shoes. We love our floors!"),
        ("Do you have changing rooms?", "No, but we do have several large bathrooms with space to change."),
        ("Where do I store my things?", "There is plenty of space for coats and shoes in our lobby, as well as cubbies inside our dance rooms!"),
        ("What if I'm late for class (or need to leave early)?", "All good! We understand that life doesn’t always run on a schedule, but we want you to be able to dance. Just check in with the front desk."),
        ("Do I need to make a reservation?", "Reservations are always helpful, but not required. Even if you’ve made a reservation, please check in at the front desk. If you have a reservation and don’t check in, we will assume you were in the class, and your account will reflect that. If you’ve made a reservation but cannot attend, please cancel online, or call the studio at 207-536-4617."),
        ("How do I pay?", "You can pay online when you register, with a card at the studio, via Venmo, or cash."),
        ("What do you recommend to someone new?", "Come for the fun, the community, and the moves! Don’t worry about getting it “right.” As long as you’re moving and having fun, that’s great! And, it usually takes a few classes to feel comfortable with the routines."),
        ("How many classes a day am I allowed to take?", "As many as you like! All day dancing is encouraged!"),
        ("Do I book a massage with you?", "Please book your massage directly with the massage therapist. Info and scheduling info can be found on the massage room door at the studio. Or, to book a massage with Lindsey online, please visit ladyloveholistics.com."),
        ("Do you take cash?", "Yes!"),
        ("Can I try it for free before I sign up?", "Yes!! Make a reservation online or drop in any time!"),
        ("Can I leave my kid in the lobby?", "No. We are not equipped or licensed to provide childcare."),
        ("Will I get shut out if I’m late?", "No! We have wonderful, understanding front desk staff that want to get you in the room dancing! Just check in with them."),
        ("Are you sensitive about your plumbing?", "Yes! We have had several expensive plumbing emergencies due to 'flushable' items being flushed. Please dispose of everything except toilet paper in our trash cans."),
        ("Can I have my private party with you?", "Yes! We are happy to host your special event! Think staff gathering, team building event, TikTok party, bachelorette party, wedding dance lessons, you name it! Please email Hilary at hilary@bodypositivedancefitness.com."),
        ("Do you sell water?", "No, due to the environmental impact of plastic bottles. We sell brand-new BPDF water bottles, as well as upcycled water bottles for a minimal fee. Please use our bottle fillers/water fountains.")
    ]

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Frequently Asked Questions")
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 24)
                        .padding(.bottom, 20)

                    ForEach(faqItems.indices, id: \.self) { index in
                        FAQItem(
                            question: faqItems[index].question,
                            answer: faqItems[index].answer,
                            isExpanded: expandedQuestions.contains(index),
                            isClosing: closingIndex == index,
                            toggleExpanded: { toggleQuestion(index) }
                        )
                    }
                }
                .padding()
            }

            // Dismiss button (smaller and grey)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss() // Dismiss the view
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20) // Smaller size
                            .foregroundColor(Color.gray) // Grey color
                            .padding(8)
                    }
                    .padding(.top, 5)
                    .padding(.trailing, 5)
                }
                Spacer()
            }
        }
    }

    private func toggleQuestion(_ index: Int) {
        if expandedQuestions.contains(index) {
            closingIndex = index
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                expandedQuestions.remove(index) // Remove after fade-out
                closingIndex = nil
            }
        } else {
            expandedQuestions.insert(index)
        }
    }
}

struct FAQItem: View {
    let question: String
    let answer: String
    let isExpanded: Bool
    let isClosing: Bool
    let toggleExpanded: () -> Void

    @State private var showText = false

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: toggleExpanded) {
                HStack {
                    Text(question)
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .foregroundColor(isExpanded ? Color.orange.opacity(0.8) : .primary) // Dark orange when expanded
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0)) // Flips immediately
                        .animation(.none, value: isExpanded) // No lag
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isExpanded ? Color.orange : Constants.Colors.neonCyan, lineWidth: 2)
                )
                .background(
                    RadialGradient(
                        gradient: Gradient(colors: [Constants.Colors.neonCyan.opacity(0.1), Constants.Colors.neonCyan.opacity(0.2)]),
                        center: .center,
                        startRadius: 22,
                        endRadius: 111
                    )
                    .cornerRadius(10)
                )
            }

            ZStack {
                if isExpanded || isClosing {
                    Text(answer)
                        .font(.system(size: 16, weight: .regular, design: .serif))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .opacity(showText ? 1 : 0)
                        .animation(.easeInOut(duration: 0.4), value: showText)
                        .onAppear {
                            showText = true // Fade in
                        }
                        .onChange(of: isClosing) { newValue in
                            if newValue {
                                showText = false // Fade out when closing
                            }
                        }
                }
            }
            .frame(maxHeight: isExpanded || isClosing ? nil : 0)
            .animation(.easeInOut(duration: 0.4), value: isExpanded)
        }
    }
}
