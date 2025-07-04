import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';
import '../../../shared/widgets/bottom_navigation_widget.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen>
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
        title: const Text('Gestión de Ventas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Nueva Venta', icon: Icon(Icons.add_shopping_cart)),
            Tab(text: 'Ventas del Día', icon: Icon(Icons.today)),
            Tab(text: 'Historial', icon: Icon(Icons.history)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNewSaleTab(),
          _buildTodaySalesTab(),
          _buildHistoryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewSaleDialog(context),
        backgroundColor: AppTheme.accentOrange,
        child: const Icon(Icons.add_shopping_cart, color: Colors.white),
      ),
      bottomNavigationBar: const BottomNavigationWidget(currentIndex: 2),
    );
  }

  Widget _buildNewSaleTab() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Información del Cliente',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Nombre del Cliente',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                        tooltip: 'Buscar cliente',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Productos',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_shopping_cart,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: AppSpacing.sm),
                          Text(
                            'No hay productos agregados',
                            style: AppTextStyles.bodyMedium,
                          ),
                          Text(
                            'Toca el botón + para agregar productos',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppBorderRadius.medium),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: AppTextStyles.heading2,
                    ),
                    Text(
                      '\$0',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Procesar Venta'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySalesTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'No hay ventas registradas hoy',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Las ventas del día aparecerán aquí',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'No hay historial de ventas',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'El historial de ventas aparecerá aquí',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showNewSaleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva Venta'),
        content: const Text('Funcionalidad en desarrollo'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
