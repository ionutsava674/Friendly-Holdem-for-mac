//
//  ContactView.swift
//  Friendly Holdem
//
//  Created by Ionut Sava on 16.01.2023.
//

import SwiftUI
#if os(iOS)
import MessageUI
#endif

struct ContactView: View {
    @Binding var isPresented: Bool
#if os(iOS)
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var showingMail = false
#endif
    let mailToAddr = "ionutsava027@gmail.com"
    let mailToNameAddr = "\"Ionut Sava\" <ionutsava027@gmail.com>"
    let mailSubject = "contacting for Friendly Holdem"
    var mailUrl: URL? {
        URL(string: "mailto:\( mailToNameAddr.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? mailToAddr )?subject=\( mailSubject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "" )")
    } //cv

    let gitHubPageUrl = "https://ionutsava674.github.io/Friendly-Holdem-for-mac/"
    let appStoreReviewUrl = "https://apps.apple.com/app/id1632308313?action=write-review"
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                Button("Back") {
                    //withAnimation {
                        self.isPresented = false
                    //}
                } //btn
                .font(.title)
                .padding()
                Spacer()
            } //hs
            Text("Contact")
                .font(.title.bold())
            #if os(macOS)
            if let murl = self.mailUrl {
                Text("For suggestions, bugs, critics etc 😅 feel free to drop me an email:")
                Link(destination: murl) {
                    Text( self.mailToNameAddr )
                } //link
            } //ifl
#elseif os(iOS)
            Text("For suggestions, bugs, critics etc 😅 feel free to drop me an email:")
            Button( self.mailToNameAddr) {
                self.showingMail = true
            } //btn
            .disabled( !MFMailComposeViewController.canSendMail())
            #endif
            if let gurl = URL(string: self.gitHubPageUrl) {
                Link(destination: gurl) {
                    Text("Visit the project website on github")
                        .accessibilityLabel(Text("Visit the project website on GitHub."))
                } //link
                .padding(.vertical)
                .padding(.vertical)
            } //ifl
#if os(iOS)
            Text("If you enjoy Friendly Holdem, and like the fact that it's free, you can really help out by giving a rating and leaving a good review on the app store.")
            Link(destination: URL(string: self.appStoreReviewUrl)!) {
                Text("rate and review on the app store")
            } //link
            Text("")
                .accessibilityHidden(true)
            #endif
            Text("Special thanks to Daniel from tekeye.uk for his free deck of cards:")
            Link(destination: URL(string: "https://tekeye.uk/playing_cards/svg-playing-cards")!) {
                Text("https://tekeye.uk/playing_cards/svg-playing-cards")
                    .multilineTextAlignment(.leading)
            } //link

        } //vs
            .padding()
#if os(iOS)
            .sheet(isPresented: $showingMail) {
                //
            } content: {
                MailComposerView(result: self.$mailResult, toRecipient: self.mailToAddr, subject: self.mailSubject)
            } //mail
        #endif
    } //body
} //str
