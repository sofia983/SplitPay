import 'package:flutter/material.dart';

class RegisterExpenseScreen extends StatefulWidget {
  const RegisterExpenseScreen({super.key});

  @override
  State<RegisterExpenseScreen> createState() =>
      _RegisterExpenseScreenState();
}

class _RegisterExpenseScreenState
    extends State<RegisterExpenseScreen> {
  final TextEditingController _descriptionController =
      TextEditingController();

  final TextEditingController _amountController =
      TextEditingController();

  String _selectedCurrency = 'COP';
  String _selectedPayer = 'Juan';
  String _selectedDate = '24/09/2026';

  final List<String> _participants = [
    'Juan',
    'Ana',
    'Luis',
  ];

  final Set<String> _selectedParticipants = {
    'Juan',
    'Ana',
    'Luis',
  };

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      _selectedDate =
          '${selectedDate.day.toString().padLeft(2, '0')}/'
          '${selectedDate.month.toString().padLeft(2, '0')}/'
          '${selectedDate.year}';
    });
  }

  void _saveExpense() {
    // En esta etapa el gasto no se guarda en una base de datos.
    // Firestore se implementará posteriormente.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Gasto preparado correctamente. '
          'El almacenamiento se implementará posteriormente.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF25243A),
        elevation: 0,
        title: const Text(
          'Registrar gasto',
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
            const Text(
              'Nuevo gasto',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF25243A),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Completa la información del gasto compartido.',
              style: TextStyle(
                color: Color(0xFF777687),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFE8E6F0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Información del gasto',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF25243A),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      hintText: 'Ej. Mercado',
                      prefixIcon: const Icon(
                        Icons.receipt_long_outlined,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8F7FC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      hintText: '120000',
                      prefixIcon: const Icon(
                        Icons.attach_money_rounded,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8F7FC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Selección de moneda.
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCurrency,
                    decoration: InputDecoration(
                      labelText: 'Moneda',
                      prefixIcon: const Icon(
                        Icons.payments_outlined,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8F7FC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'COP',
                        child: Text('Peso colombiano (COP)'),
                      ),
                      DropdownMenuItem(
                        value: 'USD',
                        child: Text('Dólar estadounidense (USD)'),
                      ),
                      DropdownMenuItem(
                        value: 'EUR',
                        child: Text('Euro (EUR)'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _selectedCurrency = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // Selección de fecha.
                  InkWell(
                    onTap: _selectDate,
                    borderRadius: BorderRadius.circular(15),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Fecha',
                        prefixIcon: const Icon(
                          Icons.calendar_today_outlined,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8F7FC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      child: Text(
                        _selectedDate,
                        style: const TextStyle(
                          color: Color(0xFF25243A),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    '¿Quién pagó?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF25243A),
                    ),
                  ),

                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    initialValue: _selectedPayer,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8F7FC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: _participants.map((person) {
                      return DropdownMenuItem(
                        value: person,
                        child: Text(person),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _selectedPayer = value;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Participantes',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF25243A),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Lista sencilla de participantes.
                  ..._participants.map(
                    (person) {
                      return CheckboxListTile(
                        value: _selectedParticipants.contains(person),
                        onChanged: (selected) {
                          setState(() {
                            if (selected == true) {
                              _selectedParticipants.add(person);
                            } else {
                              _selectedParticipants.remove(person);
                            }
                          });
                        },
                        title: Text(person),
                        contentPadding: EdgeInsets.zero,
                        activeColor: const Color(0xFF6C3FE8),
                        controlAffinity:
                            ListTileControlAffinity.leading,
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: _saveExpense,
                      icon: const Icon(
                        Icons.check_circle_outline_rounded,
                      ),
                      label: const Text(
                        'Guardar gasto',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C3FE8),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
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