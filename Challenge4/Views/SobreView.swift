/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI

struct SobreView: View {
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Image("Logo Horizontal")
                    .resizable()
                    .frame(height: 60)
                
                Spacer()
                    .frame(height: 25)
                
                Text("""
            Bem-vindo ao **HearTrack** - o seu aplicativo gratuito para o registro da sua pressão arterial!\n
            Você poderá informar os valores da sua pressão arterial para manter um histórico pessoal, e também adicionar seus medicamentos anti-hipertensivos para receber um lembrete de quando tomá-los.\n
            Este aplicativo é um registro pessoal, por isso, ressaltamos que o HearTrack não deve ser utilizado como laudo médico ou diagnóstico de doenças cardíacas. É de responsabilidade do usuário a correta utilização da plataforma.\n
            Todos os dados informados não serão compartilhados e são de inteira responsabilidade dos próprios usuários.
            """)
                
                Spacer()
                    .frame(height: 50)
                
                Text("Sobre os Desenvolvedores")
                    .font(.headline)
                    .bold()
                
                Text("HearTrack foi desenvolvido por uma equipe dedicada, que teve como objetivo ajudar os nossos usuários a cuidar da saúde do seu coração.")
                
                Spacer()
                    .frame(height: 25)
                
                Text("Equipe:")
                        .bold()
                                
                Spacer()
                .frame(height: 10)
                                
                Text("""
                     [Alissa Miki Usami Yoshioka](https://www.linkedin.com/in/alissamiki/)
                     [Amanda Rodrigues](https://www.linkedin.com/in/amanda-c-rodrigues)
                     [Guilherme Souza Santos](https://www.linkedin.com/feed/?trk=guest_homepage-basic_nav-header-signin)
                     [João Victor Farias Teixeira](https://www.linkedin.com/in/jo%C3%A3o-victor-farias-teixeira-83a313265/)
                     [Maria Mercedes da Silva Rodrigues](www.linkedin.com/in/maria-mercedes-rodrigues)
                     """)
            }
            .padding(50)
        }
        .navigationTitle("Sobre")
    }
}

#Preview {
    SobreView()
}
