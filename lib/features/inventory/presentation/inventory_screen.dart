import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';
import '../../../shared/widgets/bottom_navigation_widget.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen>
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
        title: const Text('Gestión de Inventario'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Productos', icon: Icon(Icons.inventory_2)),
            Tab(text: 'Stock Actual', icon: Icon(Icons.warehouse)),
            Tab(text: 'Alertas', icon: Icon(Icons.warning)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProductsTab(),
          _buildStockTab(),
          _buildAlertsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddInventoryDialog(context),
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const BottomNavigationWidget(currentIndex: 1),
    );
  }

  Widget _buildProductsTab() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.eco, color: AppTheme.successGreen),
            title: const Text('Arracacha'),
            subtitle: const Text('Productos disponibles: 0'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddProductDialog(context, 'Arracacha'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.eco, color: AppTheme.successGreen),
            title: const Text('Ahuyama'),
            subtitle: const Text('Productos disponibles: 0'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddProductDialog(context, 'Ahuyama'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.eco, color: AppTheme.successGreen),
            title: const Text('Frijol'),
            subtitle: const Text('Productos disponibles: 0'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddProductDialog(context, 'Frijol'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.eco, color: AppTheme.successGreen),
            title: const Text('Tomate de Árbol'),
            subtitle: const Text('Productos disponibles: 0'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddProductDialog(context, 'Tomate de Árbol'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.eco, color: AppTheme.successGreen),
            title: const Text('Pepino de Guiso'),
            subtitle: const Text('Productos disponibles: 0'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddProductDialog(context, 'Pepino de Guiso'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.eco, color: AppTheme.successGreen),
            title: const Text('Curuba'),
            subtitle: const Text('Productos disponibles: 0'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddProductDialog(context, 'Curuba'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStockTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'No hay productos en stock',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Agrega productos al inventario para verlos aquí',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 64,
            color: AppTheme.successGreen,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'No hay alertas',
            style: AppTextStyles.bodyLarge,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Todos los productos están en buen estado',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAddInventoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar al Inventario'),
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

  void _showAddProductDialog(BuildContext context, String productName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agregar $productName'),
        content: Text('Agregar $productName al inventario'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
