Versión utilizada de Flutter
Flutter (Channel stable, 3.16.5, on Microsoft Windows [Versi¢n 10.0.19045.4412], locale es-ES)

## Configuración del Entorno

### 1. Instalar Flutter y Dart

Sigue las instrucciones oficiales de Flutter para instalar el Flutter SDK y el Dart SDK:

- [Instrucciones de instalación de Flutter](https://flutter.dev/docs/get-started/install)

### 2. Verificar la Instalación


flutter doctor

_________________________
### Clonar el proyecto
git clone https://github.com/AlejoWally666/picoPlacaFront
cd picoPlacaFront

### Configurar el Canal Web
flutter channel beta
flutter upgrade
flutter config --enable-web

### Actualizar librerías y dependencias
flutter pub get

### Ejecutar la aplicación
flutter run -d chrome