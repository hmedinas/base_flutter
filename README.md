# Base Flutter

Un proyecto Flutter estructurado con Clean Architecture para facilitar el desarrollo escalable y mantenible.

## Estructura del Proyecto

Este proyecto sigue los principios de **Clean Architecture** organizando el código en capas claramente definidas con separación de responsabilidades.

```
lib/
├── core/                           # Funcionalidad compartida en toda la aplicación
│   ├── api/                        # Servicios base para comunicación con APIs
│   │   └── base_api_service.dart
│   ├── config/                     # Configuraciones de la aplicación
│   ├── constants/                  # Constantes globales
│   ├── errors/                     # Manejo de errores y excepciones
│   ├── extensions/                 # Extensiones de Dart/Flutter
│   ├── helpers/                    # Funciones auxiliares
│   ├── router/                     # Configuración de rutas/navegación
│   ├── shared/                     # Entidades y modelos compartidos
│   │   ├── data/
│   │   │   └── models/            # Modelos de datos compartidos
│   │   └── domain/
│   │       └── entities/          # Entidades compartidas
│   ├── theme/                      # Temas y estilos
│   ├── utils/                      # Utilidades generales
│   ├── widgets/                    # Widgets reutilizables
│   └── app_state.dart             # Estado global de la aplicación
│
├── features/                       # Módulos de funcionalidad (por feature)
│   ├── auth/                       # Feature de autenticación
│   │   ├── data/
│   │   │   ├── datasource/        # Fuentes de datos (local/remote)
│   │   │   │   ├── auth_local_data_source.dart
│   │   │   │   └── auth_remote_data_source.dart
│   │   │   ├── models/            # Modelos de datos (DTOs)
│   │   │   └── repositories/      # Implementación de repositorios
│   │   ├── domain/
│   │   │   ├── entities/          # Entidades del negocio
│   │   │   ├── repositories/      # Contratos de repositorios (interfaces)
│   │   │   └── usecase/           # Casos de uso (lógica de negocio)
│   │   └── presentation/
│   │       ├── pages/             # Páginas/Pantallas
│   │       ├── provider/          # Gestión de estado (Provider/Riverpod/Bloc)
│   │       └── widgets/           # Widgets específicos de auth
│   │
│   └── error/                      # Feature de manejo de errores
│
└── main.dart                       # Punto de entrada de la aplicación
```

## Capas de Clean Architecture

### 1. **Domain Layer (Capa de Dominio)**
- **Ubicación**: `features/[feature]/domain/`
- **Responsabilidad**: Lógica de negocio pura, independiente de frameworks
- **Contiene**:
  - `entities/`: Objetos de negocio (clases POJO/modelos inmutables)
  - `repositories/`: Interfaces (contratos) de repositorios
  - `usecase/`: Casos de uso (acciones específicas del negocio)

### 2. **Data Layer (Capa de Datos)**
- **Ubicación**: `features/[feature]/data/`
- **Responsabilidad**: Gestión de datos y comunicación externa
- **Contiene**:
  - `datasource/`: Implementaciones de fuentes de datos (API, BD local, cache)
  - `models/`: DTOs que convierten datos externos a entidades
  - `repositories/`: Implementaciones concretas de los repositorios del dominio

### 3. **Presentation Layer (Capa de Presentación)**
- **Ubicación**: `features/[feature]/presentation/`
- **Responsabilidad**: UI y gestión de estado
- **Contiene**:
  - `pages/`: Pantallas completas
  - `provider/`: Gestores de estado (Provider, Riverpod, Bloc, Cubit, etc.)
  - `widgets/`: Componentes UI reutilizables del feature

### 4. **Core**
- **Ubicación**: `core/`
- **Responsabilidad**: Funcionalidad compartida entre features
- **Contiene**: Utilidades, widgets comunes, configuraciones, constantes, helpers, etc.

## Principios de Clean Architecture Aplicados

### ✅ **Separation of Concerns**
Cada capa tiene una responsabilidad única y bien definida.

### ✅ **Dependency Rule**
Las dependencias apuntan hacia adentro:
- **Presentation** → **Domain** ← **Data**
- El dominio no conoce detalles de implementación
- Las capas externas dependen de las internas, nunca al revés

### ✅ **Testability**
- Lógica de negocio aislada y testeable
- Inyección de dependencias facilita el testing
- Uso de interfaces/abstracciones

### ✅ **Scalability**
- Estructura modular por features
- Fácil agregar nuevas funcionalidades
- Bajo acoplamiento entre módulos

## Instalación

```bash
# Clonar el repositorio
git clone <repository-url>

# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

## Configuración Recomendada

### Dependencias Sugeridas

Agrega estas dependencias a tu `pubspec.yaml` para completar la arquitectura:

```yaml
dependencies:
  # State Management
  flutter_riverpod: ^2.5.1  # o provider/bloc según preferencia
  
  # API & Networking
  dio: ^5.4.1
  retrofit: ^4.0.3
  
  # Local Storage
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Dependency Injection
  get_it: ^7.6.7
  injectable: ^2.3.2
  
  # Functional Programming
  dartz: ^0.10.1  # Para Either<Failure, Success>
  
  # Navigation
  go_router: ^13.2.0
  
  # Utilities
  equatable: ^2.0.5
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  # Code Generation
  build_runner: ^2.4.8
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  injectable_generator: ^2.4.1
  retrofit_generator: ^8.0.6
  hive_generator: ^2.0.1
  
  # Testing
  mockito: ^5.4.4
  flutter_test:
    sdk: flutter
```

## Convenciones de Código

### Nomenclatura
- **Entities**: Sustantivos en singular (`User`, `Product`)
- **Use Cases**: Verbos + sustantivo (`GetUserUseCase`, `LoginUseCase`)
- **Repositories**: Sustantivo + "Repository" (`UserRepository`, `AuthRepository`)
- **Data Sources**: Descriptivo + "DataSource" (`UserRemoteDataSource`, `UserLocalDataSource`)
- **Models**: Sustantivo + "Model" (`UserModel`, `ProductModel`)

### Estructura de Features
Cada feature debe ser autocontenido y seguir la misma estructura:
```
feature_name/
├── data/
├── domain/
└── presentation/
```

## Testing

```bash
# Ejecutar todos los tests
flutter test

# Ejecutar tests con coverage
flutter test --coverage

# Ver reporte de coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Recursos

- [Flutter Documentation](https://docs.flutter.dev/)
- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture Guide](https://resocoder.com/flutter-clean-architecture-tdd/)

## Contribución

1. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
2. Sigue los principios de Clean Architecture
3. Asegúrate de que todos los tests pasen
4. Crea un Pull Request

## Licencia

Este proyecto está bajo la licencia especificada en el archivo LICENSE.
