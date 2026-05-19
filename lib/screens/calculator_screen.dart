import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  static const List<String> _buttons = [
    'C',
    '*',
    '/',
    '<-',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '%',
    '0',
    '.',
    '=',
  ];

  String _display = '';
  double? _firstNum;
  String? _operator;

  void _onButtonPressed(String label) {
    setState(() {
      if (label == 'C') {
        _display = '';
        _firstNum = null;
        _operator = null;
      } else if (label == '<-') {
        if (_display.isNotEmpty) {
          _display = _display.substring(0, _display.length - 1);
        }
      } else if ('+-*/%'.contains(label)) {
        _firstNum = double.tryParse(_display);
        _operator = label;
        _display = '';
      } else if (label == '=') {
        final secondNum = double.tryParse(_display);
        if (_firstNum != null && secondNum != null && _operator != null) {
          double result = 0;
          switch (_operator) {
            case '+':
              result = _firstNum! + secondNum;
              break;
            case '-':
              result = _firstNum! - secondNum;
              break;
            case '*':
              result = _firstNum! * secondNum;
              break;
            case '/':
              result = secondNum == 0 ? double.nan : _firstNum! / secondNum;
              break;
            case '%':
              result = _firstNum! % secondNum;
              break;
          }
          _display = result.toString();
          _firstNum = null;
          _operator = null;
        }
      } else {
        _display += label;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Display area
          Container(
            width: double.infinity,
            height: 70,
            padding: const EdgeInsets.all(12),
            alignment: Alignment.centerRight,
            color: Colors.grey.shade200,
            child: Text(
              _display,
              style: const TextStyle(fontSize: 26, color: Colors.black),
            ),
          ),
          const SizedBox(height: 8),
          // Buttons area
          Expanded(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(), // no scrolling
              crossAxisCount: 4, // 4 columns
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.1, // makes buttons smaller to fit 5 rows
              children: [
                for (final label in _buttons)
                  ElevatedButton(
                    onPressed: () => _onButtonPressed(label),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 20),
                    ), // smaller text
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
