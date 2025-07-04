import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';
import '../../../shared/widgets/bottom_navigation_widget.dart';

class QualityControlScreen extends StatefulWidget {
  const QualityControlScreen({super.key});

  @override
  State<QualityControlScreen> createState() => _QualityControlScreenState();
}

class _QualityControlScreenState extends State<QualityControlScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Calidad'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Revisiones', icon: Icon(Icons.health_and_safety)),
            Tab(text: 'Mermas', icon: Icon(Icons.delete_outline)),
            Tab(text: 'Rotación', icon: Icon(Icons.refresh)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildQualityChecksTab(),
          _buildMermasTab(),
          _buildRotationTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQualityCheckDialog(context),
        backgroundColor: AppTheme.warningAmber,
        child: const Icon(Icons.add_task, color: Colors.white),
      ),
      bottomNavigationBar: const BottomNavigationWidget(currentIndex: 5),
    );
  }

  Widget _buildQualityChecksTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.health_and_safety_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'No hay revisiones registradas',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Las revisiones de calidad aparecerán aquí',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMermasTab() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumen de Mermas',
                  style: AppTextStyles.heading3,
                ),
                const SizedBox(height: AppSpacing.md),
                _buildMermaStatRow('Total del Mes', '\$0'),
                const Divider(),
                _buildMermaStatRow('Por Vencimiento', '\$0'),
                const Divider(),
                _buildMermaStatRow('Por Daño', '\$0'),
                const Divider(),
                _buildMermaStatRow('Otras Causas', '\$0'),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const Center(
          child: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 48,
                color: AppTheme.successGreen,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'No hay mermas registradas',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRotationTab() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.primaryGreen,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Sistema FIFO - Primero en Entrar, Primero en Salir',
                      style: AppTextStyles.heading3.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Los productos más antiguos se priorizan para la venta automáticamente.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppTheme.onBackgroundLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.refresh,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                'No hay productos para rotar',
                style: AppTextStyles.bodyLarge,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Los productos próximos a vencer aparecerán aquí',
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMermaStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium,
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.errorRed,
            ),
          ),
        ],
      ),
    );
  }

  void _showQualityCheckDialog(BuildContext context) {
    String selectedProduct = 'Arracacha';
    int qualityScore = 5;
    String freshnessLevel = 'Excelente';
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Nueva Revisión de Calidad'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedProduct,
                  decoration: const InputDecoration(
                    labelText: 'Producto',
                    prefixIcon: Icon(Icons.eco),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Arracacha', child: Text('Arracacha')),
                    DropdownMenuItem(value: 'Ahuyama', child: Text('Ahuyama')),
                    DropdownMenuItem(value: 'Frijol', child: Text('Frijol')),
                    DropdownMenuItem(value: 'Tomate de Árbol', child: Text('Tomate de Árbol')),
                    DropdownMenuItem(value: 'Pepino de Guiso', child: Text('Pepino de Guiso')),
                    DropdownMenuItem(value: 'Curuba', child: Text('Curuba')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedProduct = value!;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Puntuación de Calidad: $qualityScore/5 ($freshnessLevel)',
                  style: AppTextStyles.bodyMedium,
                ),
                Slider(
                  value: qualityScore.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: qualityScore.toString(),
                  onChanged: (value) {
                    setState(() {
                      qualityScore = value.round();
                      if (qualityScore == 5) {
                        freshnessLevel = 'Excelente';
                      } else if (qualityScore == 4) {
                        freshnessLevel = 'Bueno';
                      } else if (qualityScore == 3) {
                        freshnessLevel = 'Regular';
                      } else if (qualityScore == 2) {
                        freshnessLevel = 'Malo';
                      } else {
                        freshnessLevel = 'Crítico';
                      }
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(
                    labelText: 'Observaciones',
                    prefixIcon: Icon(Icons.notes),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Revisión de calidad registrada'),
                    backgroundColor: AppTheme.successGreen,
                  ),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
