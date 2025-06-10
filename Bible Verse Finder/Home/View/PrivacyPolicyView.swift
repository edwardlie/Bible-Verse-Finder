//
//  PrivacyPolicyView.swift
//  Bible Verse Finder
//
//  Created by Edward Lie on 5/9/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 40) {
        ScrollView {
                Text("Privacy Policy")
                    .font(.system(size: 64))
                    .multilineTextAlignment(.center)
                
                Text("""
                The VerseSearch iOS app does not collect any user data of any kind.
                """)
                
                Text("Terms of Use")
                    .font(.system(size: 64))
                    .multilineTextAlignment(.center)
                
                Text("""
                1. Introduction
                Welcome to VerseSearch. These Terms of Use (“Terms”) govern your access to and use of the App provided by the developer. By downloading, installing, or using the App, you agree to be bound by these Terms.
                
                2. Definitions
                “User” refers to any individual who downloads, installs, or uses the App.
                “Content” refers to all text, images, audio, video, and other material provided in the App.
                
                3. License to Use
                We grant you a limited, non-exclusive, non-transferable, revocable license to use the App for personal, non-commercial purposes, subject to these Terms.
                
                4. Acceptable Use
                You agree not to:
                
                Use the App for any unlawful purpose.
                
                Harass, threaten, or abuse other users.
                
                Attempt to reverse engineer, decompile, or disassemble the App.
                
                Upload or transmit any viruses or malicious code.
                
                5. User Accounts
                If the App requires an account, you are responsible for maintaining the confidentiality of your login information and for all activities that occur under your account.
                
                6. Termination
                We reserve the right to suspend or terminate your access to the App at our sole discretion, without notice, for conduct that we believe violates these Terms or is harmful to other users or us.
                
                7. Intellectual Property
                All intellectual property rights in the App and its content are owned by us or our licensors. You may not use, copy, or distribute any part of the App without our written permission.
                
                8. User-Generated Content
                If you submit content to the App, you grant us a worldwide, royalty-free license to use, reproduce, and display such content in connection with the App.
                
                9. Payment
                If the App includes paid features, all payments are subject to our payment terms and the app store’s policies.
                
                10. Privacy Policy
                Your use of the App is also governed by our Privacy Policy found above.
                
                11. Disclaimer of Warranties
                The App is provided “as is” and “as available” without warranties of any kind. We do not guarantee that the App will be error-free or uninterrupted.
                
                12. Limitation of Liability
                We are not liable for any damages arising from your use of the App, including but not limited to loss of data or business interruption.
                
                13. Governing Law
                These Terms are governed by the laws of the United States of America. Any disputes will be resolved in the courts of the United States of America.
                
                14. Changes to Terms
                We may update these Terms from time to time. Continued use of the App after changes constitutes acceptance of the new Terms.
                
                15. Contact Information
                For questions about these Terms, contact us on the Apple App Store.
                """
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        
        Button {
            dismiss()
        } label: {
            Text("Close")
                .foregroundColor(.white)
                .frame(width: 340)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color("AppColor"))
                )
        }
    }
}

#Preview {
    PrivacyPolicyView()
}
