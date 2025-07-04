# Copilot Instructions for ATR Inventory Control

<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

## Project Overview
This is a Flutter mobile application for agricultural inventory and sales management with the following key features:

- **Modular Architecture**: Each feature is separated into its own module for maintainability
- **Agricultural Focus**: Specialized for products like arracacha, ahuyama, frijol, tomate de árbol, pepino de guiso, curuba
- **Multiple Units**: Support for sales by bulto, canastilla, kilos, libras, octavos, cuartos, medios
- **Inventory Rotation**: Date-based inventory management with FIFO rotation alerts
- **Client Management**: Complete customer relationship management
- **Quality Control**: Product freshness tracking and mermas management
- **Excel Reports**: Export capabilities for WhatsApp sharing
- **Professional Database**: SQLite with proper relationships and migrations

## Code Guidelines
- Use clean architecture principles (Domain, Data, Presentation layers)
- Implement proper error handling and validation
- Follow Flutter best practices for state management using Riverpod
- Use GetIt for dependency injection
- Implement proper testing strategies
- Follow Spanish naming conventions for user-facing text
- Use English for code and technical documentation
- Ensure responsive design for different screen sizes
- Implement proper database relationships and queries

## Key Features to Remember
1. **Product Weight Variations**: Different products have different weights for octavos, cuartos, and medios
2. **Date-based Rotation**: Always prioritize older inventory for sales alerts
3. **Professional Reports**: Excel exports must be production-ready
4. **Modular Structure**: Each feature should be independently maintainable
5. **Data Integrity**: Maintain consistency across inventory, sales, and client data
