import SwiftUI

struct ContentView: View {
    // Array of all 52 cards
    @State private var cards = ["A❤", "2❤", "3❤", "4❤", "5❤", "6❤", "7❤", "8❤", "9❤", "10❤", "J❤", "Q❤", "K❤",
                                "A♣", "2♣", "3♣", "4♣", "5♣", "6♣", "7♣", "8♣", "9♣", "10♣", "J♣", "Q♣", "K♣",
                                "A♦", "2♦", "3♦", "4♦", "5♦", "6♦", "7♦", "8♦", "9♦", "10♦", "J♦", "Q♦", "K♦",
                                "A♠", "2♠", "3♠", "4♠", "5♠", "6♠", "7♠", "8♠", "9♠", "10♠", "J♠", "Q♠", "K♠"].shuffled()
    
    // Track selected cards
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
    
    // Toggle card selection
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
    
    var cardColor: Color {
        if card.contains("❤") || card.contains("♦") {
            return .red
        } else {
            return .black
        }
    }
    
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
                // Top left corner for the rank and suit (symbol on the right)
                HStack {
                    Text(card.prefix(1)) // Rank
                        .font(.headline)
                        .foregroundColor(cardColor)
                    Text(card.suffix(1)) // Suit
                        .font(.headline)
                        .foregroundColor(cardColor)
                    Spacer()
                }
                Spacer()
                
                // Middle of the card: Rank on the left and Suit on the right with reduced spacing
                HStack(spacing: 2) { // Reduced spacing between the rank and suit
                    Text(card.prefix(1)) // Rank
                        .font(.largeTitle)
                        .foregroundColor(cardColor)
                    Text(card.suffix(1)) // Suit
                        .font(.largeTitle)
                        .foregroundColor(cardColor)
                }
                
                Spacer()
                
                // Bottom right corner for the rank and suit (symbol on the left of the number)
                HStack {
                    Text(card.suffix(1)) // Suit
                        .font(.headline)
                        .foregroundColor(cardColor)
                    Text(card.prefix(1)) // Rank
                        .font(.headline)
                        .foregroundColor(cardColor)
                    Spacer()
                }
                .rotationEffect(.degrees(180)) // Rotate for bottom-right corner
            }
            .padding(10)
        }
        .shadow(radius: 2)
    }
}

#Preview {
    ContentView()
}
