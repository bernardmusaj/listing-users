//
//  UserRow.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import SwiftUI

struct UserRow: View {
    
    @ObservedObject var user: UserCD
    
    var body: some View {
        HStack {
            ImageView(withURL: user.avatar ?? "")
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(user.firstName ?? "").font(.title2).fontWeight(.light)
                    Text(user.lastName ?? "").font(.title2).bold()
                }
                Divider()
                Text(user.email ?? "").font(.body).foregroundColor(.gray).italic()
            }
        }
    }
}
