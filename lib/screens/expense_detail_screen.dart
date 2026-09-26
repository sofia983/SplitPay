import 'package:flutter/material.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final String description;
  final String amount;
  final String currency;
  final String date;
  final String payer;
  final List<String> participants;

  const ExpenseDetailScreen({
    super.key,
    required this.description,
    required this.amount,
    required this.currency,
    required this.date,
    required this.payer,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF25243A),
        elevation: 0,
        title: const Text(
          'Detalle del gasto',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            30,
          ),
          children: [
            // Encabezado del gasto.
            Container(
              padding: const EdgeInsets.all(24),
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
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    amount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    currency,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Información general del gasto.
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE8E6F0),
                ),
              ),
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Fecha',
                    value: date,
                  ),
                  const Divider(height: 25),
                  _DetailRow(
                    icon: Icons.person_outline_rounded,
                    label: 'Pagó',
                    value: payer,
                  ),
                  const Divider(height: 25),
                  _DetailRow(
                    icon: Icons.payments_outlined,
                    label: 'Moneda',
                    value: currency,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Participantes',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: Color(0xFF25243A),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE8E6F0),
                ),
              ),
              child: Column(
                children: participants.map(
                  (person) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color(0xFFEDE7FF),
                        foregroundColor:
                            const Color(0xFF6C3FE8),
                        child: Text(
                          person.substring(0, 1),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      title: Text(
                        person,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF25243A),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF2E8B62),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // Información que se implementará posteriormente.
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2FF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF3478D5),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'La distribución exacta del gasto y el balance '
                      'de cada participante se calcularán en una '
                      'etapa posterior del proyecto.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: Color(0xFF315D91),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFF0E8FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF6C3FE8),
            size: 21,
          ),
        ),

        const SizedBox(width: 13),

        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF777687),
              fontSize: 13,
            ),
          ),
        ),

        Text(
          value,
          textAlign: TextAlign.end,
          style: const TextStyle(
            color: Color(0xFF25243A),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}