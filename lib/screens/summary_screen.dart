import 'package:flutter/material.dart';

import 'group_detail_screen.dart';
import 'register_expense_screen.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF25243A),
        elevation: 0,
        title: const Text(
          'Resumen',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            18,
            20,
            100,
          ),
          children: [
            const Text(
              '¡Hola! 👋',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Color(0xFF25243A),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Aquí tienes un resumen general de tus gastos.',
              style: TextStyle(
                color: Color(0xFF777687),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 22),

            // Tarjeta principal con el total de gastos.
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8050EA),
                    Color(0xFF5D31D2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C3FE8)
                        .withValues(alpha: 0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total gastado',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$485.000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '+ \$120.000 este mes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Tarjetas con los valores pendientes y por recibir.
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Total que debo',
                    amount: '\$120.000',
                    subtitle: 'A pagar',
                    icon: Icons.arrow_downward_rounded,
                    iconColor: const Color(0xFFC63E55),
                    backgroundColor: const Color(0xFFFFEEF1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    title: 'Total que me deben',
                    amount: '\$605.000',
                    subtitle: 'A recibir',
                    icon: Icons.arrow_upward_rounded,
                    iconColor: const Color(0xFF2E8B62),
                    backgroundColor: const Color(0xFFEAF8F1),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              'Mis grupos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF25243A),
              ),
            ),

            const SizedBox(height: 12),

            // Grupo 1.
            _GroupCard(
              icon: Icons.beach_access_rounded,
              iconBackground: const Color(0xFFDDF4E9),
              title: 'Viaje a la Playa',
              members: '5 integrantes',
              status: 'Debes',
              amount: '\$450.000',
              statusColor: const Color(0xFFC63E55),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroupDetailScreen(
                      groupName: 'Viaje a la Playa',
                      memberCount: 5,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // Grupo 2.
            _GroupCard(
              icon: Icons.local_pizza_rounded,
              iconBackground: const Color(0xFFE5F2FF),
              title: 'Cena Viernes',
              members: '4 integrantes',
              status: 'Te deben',
              amount: '\$155.000',
              statusColor: const Color(0xFF2E8B62),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroupDetailScreen(
                      groupName: 'Cena Viernes',
                      memberCount: 4,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // Grupo 3.
            _GroupCard(
              icon: Icons.apartment_rounded,
              iconBackground: const Color(0xFFF0E8FF),
              title: 'Apartamento 302',
              members: '3 integrantes',
              status: 'Debes',
              amount: '\$200.000',
              statusColor: const Color(0xFFC63E55),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroupDetailScreen(
                      groupName: 'Apartamento 302',
                      memberCount: 3,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // Botón para acceder al formulario de registro de gasto.
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF6C3FE8),
        foregroundColor: Colors.white,
        elevation: 5,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterExpenseScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Registrar gasto',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: iconColor,
            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF666575),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF25243A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: iconColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final String title;
  final String members;
  final String status;
  final String amount;
  final Color statusColor;
  final VoidCallback onTap;

  const _GroupCard({
    required this.icon,
    required this.iconBackground,
    required this.title,
    required this.members,
    required this.status,
    required this.amount,
    required this.statusColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE8E7EF),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF5E4C8D),
                  size: 30,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(0xFF25243A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      members,
                      style: const TextStyle(
                        color: Color(0xFF888796),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    amount,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF9B9AA7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}