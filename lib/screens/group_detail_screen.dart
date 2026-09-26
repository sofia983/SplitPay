import 'package:flutter/material.dart';

import 'expense_detail_screen.dart';

class GroupDetailScreen extends StatelessWidget {
  final String groupName;
  final int memberCount;

  const GroupDetailScreen({
    super.key,
    required this.groupName,
    required this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF25243A),
        elevation: 0,
        title: Text(
          groupName,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            18,
            20,
            30,
          ),
          children: [
            // Encabezado del grupo.
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8050EA),
                    Color(0xFF5D31D2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: const Icon(
                      Icons.groups_rounded,
                      color: Colors.white,
                      size: 31,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          groupName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$memberCount integrantes',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Resumen del balance.
            Row(
              children: [
                Expanded(
                  child: _BalanceCard(
                    title: 'Mi balance',
                    amount: '+\$80.000',
                    color: const Color(0xFF2E8B62),
                    backgroundColor: const Color(0xFFEAF8F1),
                    icon: Icons.trending_up_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _BalanceCard(
                    title: 'Pendiente',
                    amount: '\$35.000',
                    color: const Color(0xFFC63E55),
                    backgroundColor: const Color(0xFFFFEEF1),
                    icon: Icons.schedule_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              'Gastos del grupo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF25243A),
              ),
            ),

            const SizedBox(height: 12),

            // Primer gasto.
            _ExpenseListItem(
              title: 'Mercado',
              date: '22 de septiembre de 2026',
              amount: '\$240.000',
              payer: 'Juan',
              icon: Icons.shopping_cart_outlined,
              iconBackground: const Color(0xFFEAF2FF),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpenseDetailScreen(
                      description: 'Mercado',
                      amount: '\$240.000',
                      currency: 'COP',
                      date: '22 de septiembre de 2026',
                      payer: 'Juan',
                      participants: [
                        'Juan',
                        'Ana',
                        'Luis',
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // Segundo gasto.
            _ExpenseListItem(
              title: 'Servicios',
              date: '18 de septiembre de 2026',
              amount: '\$180.000',
              payer: 'Ana',
              icon: Icons.home_outlined,
              iconBackground: const Color(0xFFF0E8FF),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpenseDetailScreen(
                      description: 'Servicios',
                      amount: '\$180.000',
                      currency: 'COP',
                      date: '18 de septiembre de 2026',
                      payer: 'Ana',
                      participants: [
                        'Juan',
                        'Ana',
                        'Luis',
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // Tercer gasto.
            _ExpenseListItem(
              title: 'Limpieza',
              date: '10 de septiembre de 2026',
              amount: '\$140.000',
              payer: 'Luis',
              icon: Icons.cleaning_services_outlined,
              iconBackground: const Color(0xFFFFF1DC),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpenseDetailScreen(
                      description: 'Limpieza',
                      amount: '\$140.000',
                      currency: 'COP',
                      date: '10 de septiembre de 2026',
                      payer: 'Luis',
                      participants: [
                        'Juan',
                        'Ana',
                        'Luis',
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            const Text(
              'Aportes de los integrantes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF25243A),
              ),
            ),

            const SizedBox(height: 12),

            _ContributionItem(
              name: 'Juan',
              amount: '\$280.000',
              percentage: '50%',
            ),

            _ContributionItem(
              name: 'Ana',
              amount: '\$150.000',
              percentage: '27%',
            ),

            _ContributionItem(
              name: 'Luis',
              amount: '\$130.000',
              percentage: '23%',
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final Color backgroundColor;
  final IconData icon;

  const _BalanceCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.backgroundColor,
    required this.icon,
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
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF666575),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpenseListItem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final String payer;
  final IconData icon;
  final Color iconBackground;
  final VoidCallback onTap;

  const _ExpenseListItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.payer,
    required this.icon,
    required this.iconBackground,
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
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE8E6F0),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF66518F),
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF25243A),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888796),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Pagó: $payer',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF777687),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF25243A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9B9AA7),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContributionItem extends StatelessWidget {
  final String name;
  final String amount;
  final String percentage;

  const _ContributionItem({
    required this.name,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8E6F0),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFEDE7FF),
            foregroundColor: const Color(0xFF6C3FE8),
            child: Text(
              name.substring(0, 1),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF25243A),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF25243A),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                percentage,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777687),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}