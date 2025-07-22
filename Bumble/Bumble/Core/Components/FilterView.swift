//
//  FilterView.swift
//  Bumble
//
//  Created by ALYSSON MENEZES on 22/07/25.
//

import SwiftUI

struct FilterView: View {
    
    var options: [String] = ["Everyone", "Trending"] // options sao hashs, por isso: \.self
    
    @Binding  var selection: String
    @Namespace private var namespace
    
    var body: some View {
        HStack (alignment: .top, spacing: 32){
            ForEach(options, id: \.self){ option in
                VStack (spacing: 8){
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium) // espessura
                    // .background(Color.red)
                    
                    if selection == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                        /*
                         Quando o objeto com o mesmo ID for removido da tela(esquerda) e for adicionado atela(direita), anima entre as duas telas, ele comprara o id com objeto
                         */
                    }
                    
                }
                .padding(.top, 8)
                .background(Color.black.opacity(0.001)) // facilitando o toque adicionaod background
                .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    selection = option
                }
            }
        }
        //MARK: ANIMATION
        .animation(.smooth, value: selection)
    }
}

//MARK: Reaproveitando a estrutura para caso de aumentar as opcoes
fileprivate struct FilterViewPreview: View {
    var options: [String] = ["Everyone", "Trending", "Hello"]
    @State private var selection = "Everyone"
    
    var body: some View {
        FilterView(options: options, selection: $selection)
    }
}

#Preview {
    FilterViewPreview()
        .padding()
}
