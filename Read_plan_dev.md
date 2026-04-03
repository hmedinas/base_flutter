## 1. Estructura y Configuración Base (Cimientos)

- **Paso 1:** Crear la estructura de carpetas (como estaa definda en el readme).

- **Paso 2:** Definir el Tema (core/theme/). Es mejor hacerlo al principio para que cuando diseñes el Login, ya uses los colores y tipografías correctas.

- **Paso 3:** Configurar el Router (core/router/). Define las rutas básicas (/, /login, /home).

## 2. Infraestructura de Red (El "Axios")

- **Paso 4:** Crear tu BaseApiService con Dio en core/api/. Aquí incluyes los interceptores.

- **Paso 5: Mocks :** Crea una carpeta assets/mocks/login_response.json. Es ideal para probar que tu modelo (UserModel.fromJson) funciona.

- Mocks de Lógica (Servicios): En Clean Architecture, creas una clase MockAuthRemoteDataSource que implemente la interfaz del servicio pero que devuelva datos fijos sin ir a internet. Ponla en test/features/auth/ o dentro de una carpeta data/datasources/mocks/ si quieres probarla en la app real.

## 3. Desarrollo de Features (El flujo real)

- **Paso 6:** Diseño del Login (UI en screens/ y widgets/).

- **Paso 7:** Crear la Lógica de Auth (Model -> Repository -> UseCase -> Provider). Aquí es donde conectas el diseño con tu "Axios" o con tus Mocks.

- **Paso 8:** Crear la Splash Screen y la lógica de redirección (¿Está logueado? Sí -> Home, No -> Login).

- **Paso 9:** Crear las Paginas de Error (404, 500, Unauthorized).

## orden de ejecucion
| Orden	| Tarea Crítica	| Ubicación Clave |
| ----------|---------|-----------|
| 1	| Estructura de carpetas	| lib/features/, lib/core/ |
| 2	| Tema Global (Colores/Fuentes)	| lib/core/theme/ |
| 3	| Router (Rutas iniciales)	| lib/core/router/ |
| 4	| BaseApiService (Dio Setup)	| lib/core/api/ |
| 5	| UI de Login & Errors (Diseño)	| .../presentation/screens/ |
| 6	| Lógica de Features (Mocks o API)	| .../data/ & .../domain/ |
| 7	| Splash & Redirección	| lib/features/initialization/ |
