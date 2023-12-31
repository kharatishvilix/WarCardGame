//
//  ContentView.swift
//  War Card Game
//
//  Created by Luka  Kharatishvili on 13.07.23.
//

import SwiftUI

struct ContentView: View {
    @State var playerCard = "back"
    @State var cpuCard = "back"

    @State var playerScore = 0
    @State var cpuScore = 0

    var body: some View {
        ZStack {
            Image("background-plain")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                Spacer()

                Button {
                    deal()
                    SoundManager.instance.playSound(sound: .cardflip)
                } label: {
                    Image("button")
                }

                Spacer()

                HStack {
                    Spacer()
                    VStack {
                        Text("Player")
                            .font(.headline)
                            .padding(.bottom, 10.0)

                        Text(String(playerScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                Spacer()
            }
        }
    }

    func deal() {
        // Randomize the player's card
        let playerCardValue = Int.random(in: 2 ... 14)
        playerCard = "back"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            playerCard = "card" + String(playerCardValue)
        }
        // Randomize the cpu's card
        let cpuCardValue = Int.random(in: 2 ... 14)
        cpuCard = "back"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            cpuCard = "card" + String(cpuCardValue)
        }

        // 0.25s delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            // Update the score
            if playerCardValue > cpuCardValue {
                playerScore += 1
                SoundManager.instance.playSound(sound: .win)

            } else if playerCardValue < cpuCardValue {
                cpuScore += 1
                SoundManager.instance.playSound(sound: .lose)

            } else {
                playerScore += 1
                cpuScore += 1
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
