# ATR Inventory Control 📱🌾

## Sistema Profesional de Gestión de Inventario y Ventas Agrícolas

ATR Inventory Control es una aplicación móvil desarrollada en Flutter que proporciona una solución completa y profesional para la gestión de inventarios y ventas de productos agrícolas.

## 🚀 Características Principales

### 📦 Gestión de Inventario
- **Productos Agrícolas Especializados**: Arracacha, Ahuyama, Frijol, Tomate de Árbol, Pepino de Guiso, Curuba
- **Múltiples Unidades de Medida**: Bulto, Canastilla, Kilos, Libras, Octavos, Cuartos, Medios
- **Pesos Específicos**: Cada producto tiene pesos definidos para octavos, cuartos y medios
- **Control por Fechas**: Sistema FIFO (Primero en Entrar, Primero en Salir)
- **Alertas de Rotación**: Notificaciones automáticas para productos próximos a vencer

### 💰 Sistema de Ventas
- **Ventas por Unidad Flexible**: Venta según las necesidades del cliente
- **Gestión de Precios**: Precios dinámicos por producto y unidad
- **Tipos de Pago**: Efectivo, crédito, mixto
- **Ventas Fiadas**: Control completo de deudas y pagos

### 👥 Gestión de Clientes
- **Base de Datos Completa**: Información detallada de clientes
- **Control de Crédito**: Límites de crédito y seguimiento de deudas
- **Tipos de Cliente**: Regular, Mayorista, Minorista
- **Historial de Compras**: Registro completo de transacciones

### 🏥 Control de Calidad
- **Revisiones Periódicas**: Sistema de puntuación de calidad
- **Control de Mermas**: Registro y análisis de pérdidas
- **Gestión de Frescura**: Alertas basadas en fechas de vencimiento
- **Reportes de Calidad**: Análisis detallado del estado de productos

### 📊 Reportes y Análisis
- **Reportes en Excel**: Generación automática para compartir por WhatsApp
- **Análisis de Ventas**: Estadísticas diarias, semanales y mensuales
- **Control de Stock**: Reportes de inventario en tiempo real
- **Dashboard Ejecutivo**: Métricas clave y KPIs

## 🚦 Instalación y Ejecución

### Prerrequisitos
- Flutter SDK 3.24.0 o superior
- Dart 3.8.1 o superior
- Android Studio / VS Code

### Pasos de Instalación

1. **Instalar dependencias**
```bash
flutter pub get
```

2. **Ejecutar la aplicación**
```bash
flutter run
```

3. **Compilar APK**
```bash
flutter build apk --release
```

## 📱 Estructura del Proyecto

```
lib/
├── core/                   # Configuraciones y utilidades
├── features/              # Módulos de funcionalidad
│   ├── dashboard/         # Pantalla principal
│   ├── inventory/         # Gestión de inventario
│   ├── sales/             # Sistema de ventas
│   ├── clients/           # Gestión de clientes
│   ├── reports/           # Reportes y análisis
│   └── quality_control/   # Control de calidad
└── shared/                # Componentes compartidos
```

## 🔄 CI/CD Automático

El proyecto incluye GitHub Actions que automáticamente:
- ✅ Compila APK en cada push
- ✅ Ejecuta tests y análisis
- ✅ Crea releases automáticos

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
