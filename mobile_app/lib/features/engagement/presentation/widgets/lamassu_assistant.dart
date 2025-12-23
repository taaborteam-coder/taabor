import 'package:flutter/material.dart';
import '../../core/services/lamassu_service.dart';
import 'lamassu_widget.dart';

class LamassuAssistant extends StatefulWidget {
  final String contextType; // 'waiting', 'near_turn', 'welcome'

  const LamassuAssistant({super.key, this.contextType = 'waiting'});

  @override
  State<LamassuAssistant> createState() => _LamassuAssistantState();
}

class _LamassuAssistantState extends State<LamassuAssistant>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  String? _message;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Auto-greet if welcome
    if (widget.contextType == 'welcome') {
      _toggleAssistant();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAssistant() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _message = LamassuService().getContextualMessage(widget.contextType);
        _controller.forward();
        // Play notification sound
        LamassuService().playNotificationSound();
        // Speak the message
        LamassuService().speak(_message!);
      } else {
        _controller.reverse();
        // Stop speaking when closed
        LamassuService().stop();
      }
    });

    // Auto hide after 5 seconds
    if (_isExpanded) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && _isExpanded) {
          setState(() {
            _isExpanded = false;
            _controller.reverse();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!LamassuService().isVip) {
      return const SizedBox.shrink();
    }

    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        // Chat Bubble
        if (_isExpanded)
          Positioned(
            bottom: 80,
            right: 0,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.amber.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lamassu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _message ?? '',
                      style: const TextStyle(fontSize: 14),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Floating Icon
        LamassuWidget(
          mode: LamassuMode.floating,
          size: 60,
          onTap: _toggleAssistant,
        ),
      ],
    );
  }
}
