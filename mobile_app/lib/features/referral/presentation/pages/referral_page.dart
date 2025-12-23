import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/di/injection.dart';
import '../bloc/referral_bloc.dart';

class ReferralPage extends StatelessWidget {
  final String userId;

  const ReferralPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReferralBloc>()
        ..add(LoadUserReferrals(userId))
        ..add(GenerateReferralCode(userId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('دعوة الأصدقاء')),
        body: BlocBuilder<ReferralBloc, ReferralState>(
          builder: (context, state) {
            String referralCode = '...';
            // int points = 0;

            if (state is ReferralCodeGenerated) {
              referralCode = state.code;
            } else if (state is ReferralsLoaded) {
              // points = state.totalPoints;
              // Assuming code might be part of state or fetched separately
            }

            // A bit simplified state handling for demo
            if (state is ReferralCodeGenerated) {
              referralCode = state.code;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header Image
                  const Icon(
                    Icons.card_giftcard,
                    size: 100,
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'ادعِ أصدقائك واحصل على نقاط!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'شارك كود الدعوة الخاص بك مع أصدقائك واحصل على 50 نقطة لكل صديق يسجل ويقوم بأول حجز.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  // Referral Code Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'كود الدعوة الخاص بك',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: referralCode),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم نسخ الكود')),
                              );
                            },
                            child: DottedBorderContainer(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    referralCode,
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.copy, color: Colors.purple),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Share Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Share.share(
                          'استخدم كود الدعوة الخاص بي $referralCode عند التسجيل في تطبيق طابور واحصل على مكافآت فورية!',
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('مشاركة الكود'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Apply Code Button (for demo purposes mainly)
                  TextButton(
                    onPressed: () {
                      _showApplyCodeDialog(context, userId);
                    },
                    child: const Text('لديك كود دعوة؟ أدخله هنا'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showApplyCodeDialog(BuildContext context, String userId) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('إدخال كود الدعوة'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'أدخل الكود هنا',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              context.read<ReferralBloc>().add(
                ApplyReferralCode(userId: userId, code: controller.text),
              );
              Navigator.pop(context);
            },
            child: const Text('تطبيق'),
          ),
        ],
      ),
    );
  }
}

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  const DottedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.purple,
          style: BorderStyle.none,
        ), // Need package for dotted border really
        color: Colors.purple.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child, // Simplified for now
    );
  }
}
