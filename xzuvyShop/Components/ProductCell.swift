//
//  ProductCell.swift
//  xzuvyShop
//
//  Created by Peter Clarke on 05.03.2023.
//

import SwiftUI

struct ProductCell: View {
    
    var product : Product
    @State var uiImage = UIImage(named: "airforceLow1")
    
    var body: some View {
        
        VStack{
            Image(uiImage: uiImage!)
                .resizable()
                .frame(width: screen.width * 0.45, height: screen.width * 0.47)
                //.cornerRadius(30)
            VStack{
                Text(product.title)
                    .font(.custom("AvenirNext-Bold", size: 16))
                Text("\(product.price) BYN")
                    .padding(.bottom)
                    .font(.custom("AvenirNext-regular", size: 16))
            }
        }
        .frame(width: screen.width * 0.45, height: screen.height * 0.27)
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 4)
        .onAppear {
            StorageService.shared.download(id: self.product.id) { result in
                switch result {
                case .success(let data):
                    if let img = UIImage(data: data) {
                        self.uiImage = img
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(id: "1",
                                     title: "Nike AirForce 1",
                                     imageUrl: "Not found", price: 314,
                                     information: "Classic shoes"))
    }
}
