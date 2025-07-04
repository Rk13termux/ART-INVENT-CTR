import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';
import '../../../shared/widgets/bottom_navigation_widget.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes y Análisis'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Quick Reports Section
          Text(
            'Reportes Rápidos',
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
              _buildReportCard(
                'Ventas del Día',
                Icons.today,
                AppTheme.accentOrange,
                () => _generateDailySalesReport(),
              ),
              _buildReportCard(
                'Inventario Actual',
                Icons.inventory,
                AppTheme.primaryGreen,
                () => _generateInventoryReport(),
              ),
              _buildReportCard(
                'Estado de Clientes',
                Icons.people,
                AppTheme.lightGreen,
                () => _generateClientsReport(),
              ),
              _buildReportCard(
                'Productos Críticos',
                Icons.warning,
                AppTheme.errorRed,
                () => _generateCriticalProductsReport(),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Excel Reports Section
          Text(
            'Reportes para WhatsApp',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: AppSpacing.md),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.file_download,
                        color: AppTheme.successGreen,
                        size: 32,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reporte Completo Excel',
                              style: AppTextStyles.heading3,
                            ),
                            Text(
                              'Genera un reporte completo en Excel para compartir por WhatsApp',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppTheme.onBackgroundLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _generateExcelReport(),
                          icon: const Icon(Icons.file_download),
                          label: const Text('Generar Excel'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      ElevatedButton.icon(
                        onPressed: () => _shareReport(),
                        icon: const Icon(Icons.share),
                        label: const Text('Compartir'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentOrange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Analytics Section
          Text(
            'Análisis y Estadísticas',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: AppSpacing.md),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  _buildStatRow('Ventas Totales del Mes', '\$0'),
                  const Divider(),
                  _buildStatRow('Productos Vendidos', '0 unidades'),
                  const Divider(),
                  _buildStatRow('Clientes Activos', '0'),
                  const Divider(),
                  _buildStatRow('Productos en Stock', '0'),
                  const Divider(),
                  _buildStatRow('Productos Críticos', '0'),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationWidget(currentIndex: 4),
    );
  }

  Widget _buildReportCard(
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

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
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
              color: AppTheme.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  void _generateDailySalesReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generando reporte de ventas del día...'),
        backgroundColor: AppTheme.accentOrange,
      ),
    );
  }

  void _generateInventoryReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generando reporte de inventario...'),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }

  void _generateClientsReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generando reporte de clientes...'),
        backgroundColor: AppTheme.lightGreen,
      ),
    );
  }

  void _generateCriticalProductsReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generando reporte de productos críticos...'),
        backgroundColor: AppTheme.errorRed,
      ),
    );
  }

  void _generateExcelReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generando reporte Excel completo...'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _shareReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abriendo opciones para compartir...'),
        backgroundColor: AppTheme.accentOrange,
      ),
    );
  }
}
