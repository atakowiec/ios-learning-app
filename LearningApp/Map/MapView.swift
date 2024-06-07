//
//  MapView.swift
//  LearningApp
//
//  Created by student on 7/6/24.
//

import SwiftUI
import MapKit

struct MapView: View {
        
    @State private var region = MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 51.235803, longitude: 22.548195),
           span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
       )
       
       var body: some View {
           VStack(spacing: 15) {
                       
               VStack(alignment: .leading, spacing: 7) {
                   
                           Text("Kontakt:")
                               .font(.title)
                               .fontWeight(.bold)
                               .padding(.bottom)
                   HStack{
                       Text("Address:")
                           .font(.title3)
                           .fontWeight(.semibold)
                       Spacer()
                       Text("Telefon:")
                           .font(.title3)
                           .fontWeight(.semibold)
                   }
                   HStack{
                       VStack(alignment: .leading)
                       {
                           Text("Nadbystrzycka 28b,")
                               .font(.body)
                           Text("20-123 Lublin")
                               .font(.body)
                           
                       }
                       Spacer()
                       VStack{
                           Text("505-505-505")
                               .font(.body)
                               .padding(.top, -22)
                       }
                   }
                           
                       }
                       .padding()
                       .frame(maxWidth: .infinity)
                       .background(Color(.secondarySystemBackground).opacity(0.6))
                       .cornerRadius(10)
                       
                       Map(coordinateRegion: $region)
                           .frame(height: 300)
                           .cornerRadius(10)
                           .shadow(radius: 5)
                           .padding(.top, 20)
                   }
                       .padding()
                   }
   }

   struct MapView_Previews: PreviewProvider {
       static var previews: some View {
           MapView()
       }
}
