//
//  NewcomersView.swift
//  NewcomersUI
//
//  Created by Andrew Elbert on 1/28/25.
//

import SwiftUI

struct FAQView: View {
    @State private var expandedQuestions: Set<Int> = []

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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Frequently Asked Questions")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 8)

                ForEach(faqItems.indices, id: \.self) { index in
                    FAQItem(
                        question: faqItems[index].question,
                        answer: faqItems[index].answer,
                        isExpanded: expandedQuestions.contains(index),
                        toggleExpanded: { toggleQuestion(index) }
                    )
                }
            }
            .padding()
        }
    }

    private func toggleQuestion(_ index: Int) {
        if expandedQuestions.contains(index) {
            expandedQuestions.remove(index)
        } else {
            expandedQuestions.insert(index)
        }
    }
}

struct FAQItem: View {
    let question: String
    let answer: String
    let isExpanded: Bool
    let toggleExpanded: () -> Void

    var body: some View {
        VStack {
            Button(action: toggleExpanded) {
                HStack {
                    Text(question)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)

            if isExpanded {
                Text(answer)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
    }
}
