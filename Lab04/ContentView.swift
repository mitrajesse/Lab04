import SwiftUI

struct ContentView: View {
    @State private var cards = ["A❤", "2❤", "3❤", "4❤", "5❤", "6❤", "7❤", "8❤", "9❤", "10❤", "J❤", "Q❤", "K❤",
                                "A♣", "2♣", "3♣", "4♣", "5♣", "6♣", "7♣", "8♣", "9♣", "10♣", "J♣", "Q♣", "K♣",
                                "A♦", "2♦", "3♦", "4♦", "5♦", "6♦", "7♦", "8♦", "9♦", "10♦", "J♦", "Q♦", "K♦",
                                "A♠", "2♠", "3♠", "4♠", "5♠", "6♠", "7♠", "8♠", "9♠", "10♠", "J♠", "Q♠", "K♠"].shuffled()
    
    @State private var selectedCards: Set<String> = []
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 10)], spacing: 10) {
                ForEach(cards, id: \.self) { card in
                    CardView(card: card, isSelected: selectedCards.contains(card))
                        .onTapGesture {
                            toggleSelection(of: card)
                        }
                }
            }
            .padding()
        }
    }
    
    private func toggleSelection(of card: String) {
        if selectedCards.contains(card) {
            selectedCards.remove(card)
        } else {
            selectedCards.insert(card)
        }
    }
}

struct CardView: View {
    let card: String
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .aspectRatio(2/3, contentMode: .fit)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.blue : Color.black, lineWidth: 2)
                )
            
            VStack {
                HStack {
                    Text(card)
                        .font(.headline)
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Text(card)
                        .font(.largeTitle)
                }
                
                Spacer()
                
                HStack {
                    Text(card)
                        .font(.headline)
                    Spacer()
                }
                .rotationEffect(.degrees(180))
            }
            .padding(10)
        }
        .shadow(radius: 2)
    }
}

#Preview {
    ContentView()
}
