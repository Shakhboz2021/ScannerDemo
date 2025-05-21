import SwiftUI
import CardScanner
import Scanner

struct ContentView: View {
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    private let delegate = ScanDelegateHandler()

    var body: some View {
        VStack(spacing: 20) {
            Text("Card Number: \(cardNumber)")
            Text("Expiry: \(expiryDate.isEmpty ? "N/A" : expiryDate)")

            Button(action: {
                let scanner = CardScanner(delegate: delegate, needExpiryDate: true)
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootVC = windowScene.windows.first?.rootViewController {
                    scanner.presentScanner(from: rootVC)
                }
            }) {
                Text("Scan Card")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .onAppear {
            delegate.onFinish = { result in
                DispatchQueue.main.async {
                    if let result = result {
                        cardNumber = result.cardNumber
                        expiryDate = result.expiryDate ?? ""
                    }
                }
            }
        }
    }
}

class ScanDelegateHandler: NSObject, ScanDelegate {
    var onFinish: ((CardScanResult?) -> Void)?

    func scannerDidFinish(with result: CardScanResult?) {
        onFinish?(result)
    }
}
