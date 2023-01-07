//
//  StepperView.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import SwiftUI

struct StepperView: View {
    @Binding var levelIndex: Int

    private let estimatedLabels = [
        "😫",
        "😢",
        "😑",
        "🙂",
        "😊"
    ]

    var body: some View {
        VStack {
            Text("Estimated Level")
                .font(.system(.footnote, weight: .bold))
                .foregroundStyle(.tint)

            // Stepper is able to be used at iOS9 or lator
            Stepper(value: $levelIndex, in: (0...estimatedLabels.count-1)) {
                Text(estimatedLabels[levelIndex])
            }
        }
    }
}

struct StepperView_Previews: PreviewProvider {
    @State static var levelIndex: Int = 2

    static var previews: some View {
        StepperView(levelIndex: $levelIndex)
    }
}
