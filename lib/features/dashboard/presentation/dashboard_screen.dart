import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_theme.dart';
import '../../../shared/widgets/bottom_navigation_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATR Inventory Control'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryGreen.withValues(alpha: 0.1),
                    AppTheme.lightGreen.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppBorderRadius.large),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Bienvenido!',
                    style: AppTextStyles.heading1.copyWith(
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Sistema de gestión de inventario y ventas agrícolas',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppTheme.onBackgroundLight,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppSpacing.xl),
            
            // Quick stats
            Text(
              'Resumen del día',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: AppSpacing.md),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Productos en Stock',
                    '0',
                    Icons.inventory,
                    AppTheme.successGreen,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Ventas Hoy',
                    '\$0',
                    Icons.trending_up,
                    AppTheme.accentOrange,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Productos Críticos',
                    '0',
                    Icons.warning,
                    AppTheme.errorRed,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Clientes Activos',
                    '0',
                    Icons.people,
                    AppTheme.lightGreen,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.xl),
            
            // Quick actions
            Text(
              'Acciones Rápidas',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: AppSpacing.md),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.2,
              children: [
                _buildActionCard(
                  context,
                  'Nuevo Producto',
                  Icons.add_box,
                  AppTheme.primaryGreen,
                  () => context.go('/inventory'),
                ),
                _buildActionCard(
                  context,
                  'Nueva Venta',
                  Icons.point_of_sale,
                  AppTheme.accentOrange,
                  () => context.go('/sales'),
                ),
                _buildActionCard(
                  context,
                  'Control de Calidad',
                  Icons.health_and_safety,
                  AppTheme.warningAmber,
                  () => context.go('/quality'),
                ),
                _buildActionCard(
                  context,
                  'Reportes',
                  Icons.analytics,
                  AppTheme.lightGreen,
                  () => context.go('/reports'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(currentIndex: 0),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppBorderRadius.large),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: AppTextStyles.heading2.copyWith(color: color),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppTheme.onBackgroundLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppBorderRadius.large),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppBorderRadius.large),        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
