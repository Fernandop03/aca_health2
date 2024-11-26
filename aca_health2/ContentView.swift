//
//  ContentView.swift
//  aca_health2
//
//  Created by CEDAM35 on 26/11/24.
//

import SwiftUI


struct ContentView: View {
    @State private var showLoginView = false
    @State private var showRegisterView = false
    @State private var showHomeView = false
    @State private var animate = false
    
    let scandinavianSky = Color(hex: "#AEC6C5")
    let crepitaColor = Color(hex: "#F1A7A6")
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [scandinavianSky, crepitaColor]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                // Círculos animados en el fondo
                ForEach(0..<6) { index in
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: CGFloat(100 + index * 50), height: CGFloat(100 + index * 50))
                        .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                  y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                        .offset(x: animate ? 50 : -50, y: animate ? -50 : 50)
                        .animation(
                            Animation.easeInOut(duration: Double.random(in: 4...6))
                                .repeatForever(autoreverses: true)
                        )
                        .scaleEffect(animate ? 1.1 : 1) // Variación de escala durante la animación
                }
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        Image("ima1")
                            .resizable()
                            .frame(width: 350, height: 350)
                            .scaleEffect(animate ? 1.05 : 1) // Efecto de escalado en el logo
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true))
                    }
                    
                    Spacer()
                    
                    // Botones de Iniciar sesión y Registrarse
                    HStack(spacing: 20) {
                        Button(action: {
                            self.showLoginView = true
                        }) {
                            Text("INICIAR SESIÓN")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                                .padding(.horizontal, 40)
                                .scaleEffect(animate ? 1.05 : 1)
                                .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true))
                        }
                        
                        Button(action: {
                            self.showRegisterView = true
                        }) {
                            Text("REGÍSTRATE")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .top, endPoint: .bottom))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                                .padding(.horizontal, 40)
                                .scaleEffect(animate ? 1.05 : 1)
                                .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true))
                        }
                    }
                    
                    Spacer()
                    
                    // Círculo blanco en la esquina inferior derecha con pulso
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 120, height: 120)
                                .scaleEffect(animate ? 1.1 : 1) // Pulso en el círculo
                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true))
                            
                            Image("pngwing.com(1)") // Cambia "brain_icon" por tu imagen
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .onAppear {
                self.animate = true
            }
            .sheet(isPresented: $showLoginView) {
                LoginView(showHomeView: self.$showHomeView)
            }
            .sheet(isPresented: $showRegisterView) {
                RegisterView()
            }
            .background(NavigationLink("", destination: HomeView(), isActive: $showHomeView).hidden())
        }
    }
}


// Extensión para Color, para manejar hexadecimales
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var showHomeView: Bool // Bind con la vista principal para abrir la vista de inicio después de iniciar sesión
    
    let limitlessColor = Color(hex: "#B0C9E5") // Color Limitless (PPG1091-3)
    let scandinavianSky = Color(hex: "#AEC6C5") // Color Scandinavian Sky (PPG1149-3)
    
    var body: some View {
        ZStack {
            // Fondo con gradiente que combina Limitless y Scandinavian Sky
            LinearGradient(gradient: Gradient(colors: [limitlessColor, scandinavianSky]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Iniciar sesión")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                // Campo de correo electrónico
                TextField("Correo electrónico", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal, 40)
                
                // Campo de contraseña
                SecureField("Contraseña", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 40)
                
                // Botón de iniciar sesión
                Button(action: {
                    // Lógica de verificación de credenciales (puedes agregar validaciones aquí)
                    self.showHomeView = true // Mostrar la vista Home después de iniciar sesión
                }) {
                    Text("INICIAR SESIÓN")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)) // Gradiente para el botón
                        .cornerRadius(8)
                        .padding(.top, 20)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
        }
    }
}

struct RegisterView: View {
    @State private var name = ""
    @State private var career = ""
    @State private var gender = "Masculino"
    @State private var age = ""
    @State private var weight = ""
    @State private var height = ""
    @State private var email = ""
    @State private var password = ""
    
    let genders = ["Masculino", "Femenino", "Otro"]
    
    var body: some View {
        ZStack {
            // Fondo azul agua para la vista de registro
            Color(hex: "#A7D8D8")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Registro")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                // Campos de registro
                Group {
                    TextField("Nombre", text: $name)
                    TextField("Carrera", text: $career)
                    Picker("Género", selection: $gender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                        }
                    }
                    TextField("Edad", text: $age)
                    TextField("Peso (kg)", text: $weight)
                    TextField("Estatura (cm)", text: $height)
                    TextField("Correo electrónico", text: $email)
                    SecureField("Contraseña", text: $password)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 40)
                
                // Botón de registro
                Button(action: {
                    // Lógica para registrar al usuario
                }) {
                    Text("REGISTRARSE")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding(.top, 20)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
        }
    }
}

struct HomeView: View {
    @State private var isMenuOpen = false // Estado para mostrar u ocultar el menú lateral
    @State private var selectedMenuItem: String? = nil // Para controlar la opción seleccionada
    
    var body: some View {
        ZStack {
            // Contenido principal
            VStack {
                // Calendario
                VStack(alignment: .leading) {
                    Text("noviembre de 2024")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(.leading)

                    // Simulación de calendario
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                        ForEach(1...30, id: \.self) { day in
                            Text("\(day)")
                                .frame(maxWidth: .infinity)
                                .padding(5)
                                .background(day == 25 ? Color.red.opacity(0.7) : Color.clear)
                                .cornerRadius(5)
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding()

                // Información del usuario
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                        .background(Color.pink)
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text("Name: Sarai Ramírez")
                            .font(.headline)
                            .foregroundColor(.black)
                        Text("Age: 22")
                            .foregroundColor(.black)
                        Text("MAC")
                            .foregroundColor(.black)
                        HStack {
                            Text("56 kg")
                                .foregroundColor(.black)
                            Spacer()
                            Text("1.65 m")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding()

                // Progreso
                VStack {
                    Text("Progreso de la semana")
                        .foregroundColor(.black)
                        .padding(.bottom, 5)

                    HStack {
                        VStack {
                            Text("Semana")
                                .foregroundColor(.black)
                            CircularProgressView(progress: 0.35)
                            Text("35%")
                                .foregroundColor(.black)
                        }
                        Spacer()
                        VStack {
                            Text("Mes")
                                .foregroundColor(.black)
                            CircularProgressView(progress: 0.46)
                            Text("46%")
                                .foregroundColor(.black)
                        }
                        Spacer()
                        VStack {
                            Text("Semana")
                                .foregroundColor(.black)
                            CircularProgressView(progress: 0.35)
                            Text("35%")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            .background(Color.white.edgesIgnoringSafeArea(.all)) // Fondo blanco
            
            // Botón de menú en la esquina superior derecha
            HamburgerMenuButton {
                withAnimation {
                    isMenuOpen.toggle()
                }
            }
            .padding()
            .padding(.top, 40) // Posicionar más arriba
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            
            // Menú lateral
            if isMenuOpen {
                SideMenu(selectedMenuItem: $selectedMenuItem) {
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true) // Elimina el botón de retroceso
        .navigationBarItems(leading: EmptyView()) // También elimina cualquier botón de retroceso
    }
}

struct SideMenu: View {
    @Binding var selectedMenuItem: String? // Enlace de estado para el item seleccionado
    var onClose: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button(action: onClose) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
            }
            
            Group {
                Text("Inicio")
                Text("Perfil")
                Text("Configuraciones")
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(.leading)

            Divider()
                .background(Color.white)

            // Opciones adicionales: Ranking, Alimentos y Contactos
            Group {
                Button(action: {
                    // Acción para navegar a CafeteriaRankingView
                    selectedMenuItem = "Ranking"
                }) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("Ranking")
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                }
                .background(
                    NavigationLink(
                        destination: Ranking(),
                        isActive: .constant(selectedMenuItem == "Ranking") // Cambia el estado del menú a CafeteriaRankingView cuando se selecciona
                    ) {
                        EmptyView()
                    }
                )

                Button(action: {
                    // Acción para navegar a AlimentosView
                    selectedMenuItem = "Alimentos"
                }) {
                    HStack {
                        Image(systemName: "leaf.fill")
                            .foregroundColor(.green)
                        Text("Alimentos")
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                }
                .background(
                    NavigationLink(
                        destination: AlimentosView(),
                        isActive: .constant(selectedMenuItem == "Alimentos") // Cambia el estado del menú a AlimentosView cuando se selecciona
                    ) {
                        EmptyView()
                    }
                )

                Button(action: {
                    // Acción para navegar a ContactView
                    selectedMenuItem = "Contactos"
                }) {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.blue)
                        Text("Contactos")
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                }
                .background(
                    NavigationLink(
                        destination: ContactView(),
                        isActive: .constant(selectedMenuItem == "Contactos") // Cambia el estado del menú a ContactView cuando se selecciona
                    ) {
                        EmptyView()
                    }
                )
                Button(action: {
                    // Acción para navegar a HealthyView
                    selectedMenuItem = "Healthy"
                }) {
                    HStack {
                        Image(systemName: "dumbbell.fill") // Cambié de hoja a pesa
                            .foregroundColor(.purple)
                        Text("Healthy")
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                }
                .background(
                    NavigationLink(
                        destination: HealthyChallengeView(),
                        isActive: .constant(selectedMenuItem == "Healthy") // Cambia el estado del menú a HealthyView cuando se selecciona
                    ) {
                        EmptyView()
                    }
                )

            }
            
            Spacer()
        }
        .frame(maxWidth: 250, maxHeight: .infinity)
        .background(Color.black.opacity(0.9))
        .edgesIgnoringSafeArea(.all)
        .transition(.move(edge: .trailing))
    }
}

struct CircularProgressView: View {
    var progress: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.5), lineWidth: 8)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.purple, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(Int(progress * 100))%")
                .font(.caption)
                .foregroundColor(.black)
        }
        .frame(width: 50, height: 50)
    }
}

struct HamburgerMenuButton: View {
    var action: () -> Void // Acción que realizará el botón al presionarlo
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) { // Espaciado entre las líneas
                Rectangle()
                    .frame(width: 30, height: 4)
                    .cornerRadius(2)
                Rectangle()
                    .frame(width: 30, height: 4)
                    .cornerRadius(2)
                Rectangle()
                    .frame(width: 30, height: 4)
                    .cornerRadius(2)
            }
            .foregroundColor(.white)
            .padding(10)
            .background(Color.black)
            .cornerRadius(10)
        }
        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2) // Sombra para darle profundidad
    }
}

struct ContactView: View {
    var body: some View {
        VStack {
            // Título de la pantalla
            Text("Contactos")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.red) // Título en rojo
                .padding(.top, 20)
            
            // Contenido interactivo
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Psicología
                    ContactSection(
                        icon: "brain.head.profile",
                        title: "Psicología",
                        details: [
                            ("UNAM:", "55-50-25-08-55", .phone),
                            ("Fes Acatlán:", "55-54-05-64-33", .phone),
                            ("Email:", "orientacionpsicologia@acatlan.unam.mx", .email)
                        ]
                    )
                    
                    // Nutrición
                    ContactSection(
                        icon: "heart.fill",
                        title: "Nutricional",
                        details: [
                            ("UNAM:", "55-56-23-23-00", .phone),
                            ("Email:", "icnh@facmed.unam.mx", .email),
                            ("Fes Acatlán:", "55-56-23-16-02", .phone),
                            ("Email:", "mobesa@acatlan.unam.mx", .email)
                        ]
                    )
                    
                    // Salud Física
                    ContactSection(
                        icon: "figure.run",
                        title: "Salud Física",
                        details: [
                            ("UNAM:", "55-56-22-05-40", .phone),
                            ("Email:", "sos@unam.mx", .email),
                            ("Fes Acatlán:", "55-56-23-16-90", .phone),
                            ("Email:", "deportes@acatlan.unam.mx", .email)
                        ]
                    )
                    
                    // Ilustración decorativa
                    Spacer()
                    Image("illustration")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                        .opacity(0.7)
                        .padding(.top, 30)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct ContactSection: View {
    let icon: String
    let title: String
    let details: [(label: String, value: String, action: ContactActionType)]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red) // Título de sección en rojo
            }

            ForEach(details, id: \.value) { detail in
                HStack(alignment: .top) {
                    Text(detail.label)
                        .foregroundColor(.red) // Texto de etiquetas en rojo
                    Spacer()
                    Link(detail.value, destination: detail.action.url(for: detail.value))
                        .foregroundColor(.red) // Texto de enlaces en rojo
                        .underline()
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

enum ContactActionType {
    case phone
    case email

    func url(for value: String) -> URL {
        switch self {
        case .phone:
            return URL(string: "tel:\(value.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: ""))")!
        case .email:
            return URL(string: "mailto:\(value)")!
        }
    }
}

struct AlimentosView: View {
    @State private var desayuno: String = ""
    @State private var comida: String = ""
    @State private var cena: String = ""
    @State private var colaciones: String = ""

    let limitlessColor = Color(hex: "#B0C9E5") // Color Limitless (PPG1091-3)
    let scandinavianSky = Color(hex: "#AEC6C5") // Color Scandinavian Sky (PPG1149-3)

    var body: some View {
        ZStack {
            // Fondo con gradiente entre Limitless y Scandinavian Sky
            LinearGradient(gradient: Gradient(colors: [limitlessColor, scandinavianSky]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Sugerencia de alimentos")
                    .font(.headline)
                    .foregroundColor(.white)

                Group {
                    CampoAlimento(icono: "🍳", etiqueta: "Desayuno 🍳", texto: $desayuno)
                    CampoAlimento(icono: "hamburger", etiqueta: "Comida 🍔", texto: $comida)
                    CampoAlimento(icono: "bowl", etiqueta: "Cena 🥣", texto: $cena)
                    CampoAlimento(icono: "🍇", etiqueta: "Colaciones 🍇", texto: $colaciones)
                }

                Button(action: cambiarCampos) {
                    Text("🔄 Otra opción")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }

    func cambiarCampos() {
        desayuno = ["Avena 🥣", "Fruta 🍎", "Pan Integral 🍞"].randomElement()!
        comida = ["Pasta 🍝", "Ensalada 🥬", "Pollo asado 🍗"].randomElement()!
        cena = ["Sopa 🍲", "Pescado 🐠", "Verduras al vapor 🥦"].randomElement()!
        colaciones = ["Yogur 🥤", "Nueces 🥜", "Galletas saludables 🍪"].randomElement()!
    }
}

struct CampoAlimento: View {
    var icono: String
    var etiqueta: String
    @Binding var texto: String

    var body: some View {
        HStack {
            Image(systemName: icono)
                .font(.title2)
                .foregroundColor(.green)

            VStack(alignment: .leading) {
                Text(etiqueta)
                    .font(.subheadline)
                    .foregroundColor(.black)

                TextField("", text: $texto)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
    }
}

struct Ranking: View {

@State private var cafeteriaName: String = "Star Café"

@State private var currentRating: String = "4.5"

@State private var estimatedBudget: String = "$150"

@State private var feedbackMessage: String = ""

// Lista simulada de cafeterías

@State private var cafeteriaIndex: Int = 0

private let cafeterias: [(String, String, String)] = [

("Café 8", "4.5", "$150"),

("Kiosco 2", "4.0", "$90"),

("Café idiomas", "4.8", "$80"),

]

var body: some View {

ZStack {

LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.white]), startPoint: .top, endPoint: .bottom)

.edgesIgnoringSafeArea(.all) // Fondo con gradiente

VStack(spacing: 25) {

Text("☕ Ranking de Cafeterías")

.font(.title)

.fontWeight(.bold)

.foregroundColor(.black)

VStack(alignment: .leading, spacing: 20) {

CampoCafeteria(icono: "🍴", etiqueta: "Cafetería:", valor: cafeteriaName)

CampoCafeteria(icono: "⭐", etiqueta: "Puntuación actual:", valor: currentRating)

CampoCafeteria(icono: "💵", etiqueta: "Presupuesto estimado:", valor: estimatedBudget)

}

.padding()

.background(Color.white.opacity(0.9))

.cornerRadius(15)

.shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 3)

Text("📝 Califica a la cafetería:")

.font(.headline)

.foregroundColor(.black)

VStack(spacing: 15) {

BotonCalificar(titulo: "Buena", color: .green) {

rateCafeteria(rating: "Buena")

}

BotonCalificar(titulo: "Regular", color: .orange) {

rateCafeteria(rating: "Regular")

}

BotonCalificar(titulo: "Mala", color: .red) {

rateCafeteria(rating: "Mala")

}

}

Button(action: goToNextCafeteria) {

Text("➡️ Siguiente cafetería")

.font(.headline)

.foregroundColor(.white)

.padding()

.frame(maxWidth: .infinity)

.background(Color.blue)

.cornerRadius(10)

.shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 3)

}

.padding(.horizontal)

if !feedbackMessage.isEmpty {

Text(feedbackMessage)

.font(.subheadline)

.foregroundColor(.purple)

.padding(.top)

}

}

.padding()

}

}

// Función para calificar cafetería

private func rateCafeteria(rating: String) {

feedbackMessage = "Calificaste la cafetería como \(rating)."

}

// Función para pasar a la siguiente cafetería

private func goToNextCafeteria() {

cafeteriaIndex = (cafeteriaIndex + 1) % cafeterias.count

let nextCafeteria = cafeterias[cafeteriaIndex]

cafeteriaName = nextCafeteria.0

currentRating = nextCafeteria.1

estimatedBudget = nextCafeteria.2

feedbackMessage = "Mostrando la siguiente cafetería."

}

}

// Vista para mostrar información de cada campo

struct CampoCafeteria: View {

var icono: String

var etiqueta: String

var valor: String

var body: some View {

HStack(spacing: 15) {

Text(icono)

.font(.largeTitle)

.frame(width: 50, height: 50)

.background(Color.purple.opacity(0.2))

.clipShape(Circle())

VStack(alignment: .leading) {

Text(etiqueta)

.font(.headline)

.foregroundColor(.purple)

Text(valor)

.padding(10)

.background(Color.white)

.cornerRadius(8)

.shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 2)

}

}

.padding(.vertical, 5)

}

}

// Vista para los botones de calificación

struct BotonCalificar: View {

var titulo: String

var color: Color

var accion: () -> Void

var body: some View {

Button(action: accion) {

Text(titulo)

.font(.headline)

.foregroundColor(.white)

.padding()

.frame(maxWidth: .infinity)

.background(color)

.cornerRadius(10)

.shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 3)

}

}

}


struct HealthyChallengeView: View {
    // Estado para el progreso y selección de retos
    @State private var selectedChallenge: String? = nil
    @State private var progress: Double = 0.0
    @State private var showCompletionAlert = false

    // Lista de retos saludables
    let challenges = [
        "Camina 10,000 pasos al día",
        "Bebe 2 litros de agua",
        "Evita el azúcar por una semana",
        "Medita 10 minutos al día",
        "Duerme al menos 8 horas",
        "Come 5 porciones de frutas o verduras"
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Reto Saludable")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                // Selector de retos
                Text("Selecciona un reto:")
                    .font(.headline)
                    .padding(.top)
               
                Picker("Selecciona un reto", selection: $selectedChallenge) {
                    Text("Selecciona un reto").tag(String?.none)
                    ForEach(challenges, id: \.self) { challenge in
                        Text(challenge).tag(String?(challenge))
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                // Texto del reto seleccionado
                if let challenge = selectedChallenge {
                    Text("Reto seleccionado:")
                        .font(.headline)
                        .padding(.top)
                    Text(challenge)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                // Barra de progreso
                Text("Progreso del reto")
                    .font(.headline)
                    .padding(.top)

                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding()

                // Botón para registrar progreso
                Button(action: {
                    if progress < 1.0 {
                        progress += 0.2 // Incrementa el progreso
                        if progress >= 1.0 {
                            showCompletionAlert = true // Mostrar alerta al completar
                        }
                    }
                }) {
                    Text("Registrar Progreso")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(progress < 1.0 ? Color.blue : Color.gray)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(selectedChallenge == nil || progress >= 1.0) // Desactivar si no hay reto seleccionado o está completado

                Spacer()
            }
            .padding()
            .navigationBarTitle("Reto Saludable", displayMode: .inline)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("White Sage"), .white]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .alert(isPresented: $showCompletionAlert) {
                Alert(
                    title: Text("¡Felicidades!"),
                    message: Text("Has completado el reto: \(selectedChallenge ?? "")"),
                    dismissButton: .default(Text("Aceptar"), action: {
                        // Reinicia el progreso y permite elegir otro reto
                        progress = 0.0
                        selectedChallenge = nil
                    })
                )
            }
        }
    }
}




#Preview {
    ContentView()
}




