import 'package:http/http.dart' as http;
import 'dart:convert';

class AIService {
  final String apiKey;
  final String baseUrl;

  AIService({required this.apiKey, this.baseUrl = 'https://api.openai.com/v1'});

  // Get smart suggestions for businesses
  Future<List<String>> getBusinessSuggestions({
    required String userPreferences,
    required String location,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a helpful assistant that suggests businesses based on user preferences.',
            },
            {
              'role': 'user',
              'content':
                  'Suggest businesses in $location based on these preferences: $userPreferences. Return only business names as a JSON array.',
            },
          ],
          'max_tokens': 200,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final content = data['choices'][0]['message']['content'];
        return List<String>.from(json.decode(content));
      }
    } catch (e) {
      // Handle error
    }
    return [];
  }

  // Predict wait time using AI
  Future<int?> predictWaitTime({
    required String businessId,
    required int currentQueueSize,
    required DateTime currentTime,
  }) async {
    // Simplified prediction logic
    // In production, this would use ML model with historical data
    final hour = currentTime.hour;
    double peakMultiplier = 1.0;

    // Peak hours (12-2 PM, 6-8 PM)
    if ((hour >= 12 && hour <= 14) || (hour >= 18 && hour <= 20)) {
      peakMultiplier = 1.5;
    }

    final baseWaitTime = currentQueueSize * 15; // 15 min per person
    return (baseWaitTime * peakMultiplier).round();
  }

  // Chatbot response
  Future<String> getChatbotResponse(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a helpful customer service assistant for Taabor queue management app. Answer questions about booking, queues, and services.',
            },
            {'role': 'user', 'content': userMessage},
          ],
          'max_tokens': 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['choices'][0]['message']['content'];
      }
    } catch (e) {
      return 'عذراً، حدث خطأ في معالجة طلبك.';
    }
    return 'عذراً، لا أستطيع الإجابة الآن.';
  }

  // Analyze user behavior
  Future<Map<String, dynamic>> analyzeUserBehavior({
    required String userId,
    required List<Map<String, dynamic>> userActivities,
  }) async {
    // Simplified analysis
    // In production, this would use ML for pattern recognition
    final analysis = {
      'preferredCategories': <String>[],
      'averageBookingTime': 0,
      'favoriteBusinesses': <String>[],
      'recommendedBusinesses': <String>[],
    };

    // Extract patterns
    final categoryCount = <String, int>{};
    for (final activity in userActivities) {
      final category = activity['category'] as String?;
      if (category != null) {
        categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      }
    }

    // Sort and get top categories
    final sortedCategories = categoryCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    analysis['preferredCategories'] = sortedCategories
        .take(3)
        .map((e) => e.key)
        .toList();

    return analysis;
  }
}
