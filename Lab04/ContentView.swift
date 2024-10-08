import SwiftUI

struct ContentView: View {
    // Array of all 52 cards, exactly as provided in the instructions
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
    
    var rank: String {
        if card.hasPrefix("10") {
            return "10"
        } else {
            return String(card.prefix(1))
        }
    }
    
    var suit: String {
        String(card.last!)
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
                // Top left corner
                HStack {
                    Text(rank)
                        .font(.headline)
                    Text(suit)
                        .font(.headline)
                    Spacer()
                }
                .foregroundColor(cardColor)
                
                Spacer()
                
                // Middle of the card
                HStack(spacing: 2) {
                    Text(rank)
                        .font(.largeTitle)
                    Text(suit)
                        .font(.largeTitle)
                }
                .foregroundColor(cardColor)
                
                Spacer()
                
                // Bottom right corner
                HStack {
                    Text(suit)
                        .font(.headline)
                    Text(rank)
                        .font(.headline)
                    Spacer()
                }
                .foregroundColor(cardColor)
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
