import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/payment.dart';
import '../bloc/payment_bloc.dart';

class PaymentPage extends StatefulWidget {
  final String bookingId;
  final double amount;
  final String userId;

  const PaymentPage({
    super.key,
    required this.bookingId,
    required this.amount,
    required this.userId,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod _selectedMethod = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PaymentBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('الدفع')),
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('تم الدفع بنجاح!')));
              Navigator.pop(context, true);
            } else if (state is PaymentError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading =
                state is PaymentLoading || state is PaymentProcessing;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text(
                            'المبلغ المطلوب',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${widget.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'طريقة الدفع',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Payment Methods
                  _PaymentMethodTile(
                    method: PaymentMethod.cash,
                    title: 'نقداً',
                    subtitle: 'الدفع عند الاستلام',
                    icon: Icons.money,
                    selected: _selectedMethod == PaymentMethod.cash,
                    onTap: () =>
                        setState(() => _selectedMethod = PaymentMethod.cash),
                  ),
                  _PaymentMethodTile(
                    method: PaymentMethod.card,
                    title: 'بطاقة ائتمان',
                    subtitle: 'Visa, Mastercard',
                    icon: Icons.credit_card,
                    selected: _selectedMethod == PaymentMethod.card,
                    onTap: () =>
                        setState(() => _selectedMethod = PaymentMethod.card),
                  ),
                  _PaymentMethodTile(
                    method: PaymentMethod.wallet,
                    title: 'محفظة رقمية',
                    subtitle: 'PayPal, Apple Pay',
                    icon: Icons.account_balance_wallet,
                    selected: _selectedMethod == PaymentMethod.wallet,
                    onTap: () =>
                        setState(() => _selectedMethod = PaymentMethod.wallet),
                  ),

                  const SizedBox(height: 32),

                  // Pay Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<PaymentBloc>().add(
                                CreatePaymentEvent(
                                  userId: widget.userId,
                                  bookingId: widget.bookingId,
                                  amount: widget.amount,
                                  method: _selectedMethod,
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'متابعة الدفع',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final PaymentMethod method;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.method,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected ? Colors.blue.withValues(alpha: 0.1) : null,
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
          color: selected ? Colors.blue : Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: selected
            ? const Icon(Icons.check_circle, color: Colors.blue)
            : const Icon(Icons.circle_outlined, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
