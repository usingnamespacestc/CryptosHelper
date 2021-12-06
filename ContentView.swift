//
//  ContentView.swift
//  crypto
//
//  Created by Tiancheng Shuai on 12/3/21.
//
//

import SwiftUI

struct ContentView: View {
    @State var cryptos: [crypto_name] = []
    @State private var selectedCrypto = "BTC"
    @State var firstAppear: Bool = true
    @State var price = NSNumber(0)
    @State var lastUpdated = NSNumber(0)
    @State var lastUpdatedConverted = ""
    init(){
        /*
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            print("毫无意义的延时")
        }
         */
         print("程序正在启动...")
    }

    var body: some View {
        NavigationView {
            Form {
//                Text("test")
                Section {
                    Picker("Select Crypto", selection: $selectedCrypto) {
                        ForEach(cryptos, id:\.self.symbol) {crypto in
                            Text(crypto.name + ", " + crypto.symbol)
//                            Text(crypto.name).tag(String(crypto.symbol))
                        }
                    }
                    HStack {
                        Text("Crypto Price (USD):")
                        Spacer()
                        Text("\(price)")
                                .padding(.trailing, 0)
                    }
                    HStack {
                        Text("Last Updated:")
                        Spacer()
                        Text(lastUpdatedConverted)
                                .padding(.trailing, 0)
                    }
//                    Button("Print cryptos") {
//                        print(selectedCrypto)
//                    }
//                    Button("Get crypto price") {
//                        APIRequest.get_crypto_price(symbol: selectedCrypto){ res in
//                            lastUpdated = res["last_updated"]
//                            price = res["price"]
//                        }
//                    }
                }
            }
            .onAppear {
                if firstAppear {
                    print("只执行一次，不要重复！")
                    APIRequest.get_crypto_list {res in
                        for i in 0 ..< res.count {
                            cryptos.append(res[i])
                        }
                        print(cryptos.count, "cryptos loaded.")
                    }
                    firstAppear = false
                }
                APIRequest.get_crypto_price(symbol: selectedCrypto){ res in
                    print("selected_crypto:", selectedCrypto)
                    print("last_update:", res["last_updated"] as Any)
                    print("price:", res["price"] as Any)
                    price = res["price"] as! NSNumber
                    lastUpdated = res["last_updated"] as! NSNumber
                    let epocTime = TimeInterval(truncating: lastUpdated)
//                    lastUpdatedConverted = "\(NSDate(timeIntervalSince1970: epocTime))"
                    lastUpdatedConverted = NSDate(timeIntervalSince1970: epocTime).description(with: TimeZone.current.abbreviation())
                    print(NSDate(timeIntervalSince1970: epocTime).description(with: TimeZone.current.abbreviation()))
                }
            }
            .navigationBarTitle(Text("CryptosHelper"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
