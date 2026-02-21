// File: lib/features/nec_codes/data/nec_data.dart
// *heavy breathing* 🫁 The data repository of NEC knowledge...

import '../../../core/constants/app_constants.dart';

class NecArticle {
  final String id;
  final String number;
  final String title;
  final String description;
  final List<String> sections;
  final bool isRequired;

  const NecArticle({required this.id, required this.number, required this.title, required this.description, this.sections = const [], this.isRequired = true});
}

abstract class NecData {
  NecData._();

  static List<NecArticle> get articles {
    return AppConstants.necCategories.map((category) {
      final parts = category.split(' - ');
      final number = parts[0].replaceAll('Article ', '');
      return NecArticle(id: 'nec_$number', number: number, title: parts.length > 1 ? parts[1] : category, description: _getDescriptionForArticle(number));
    }).toList();
  }

  static NecArticle? getByNumber(String number) {
    try { return articles.firstWhere((article) => article.number == number); }
    catch (e) { return null; }
  }

  static String _getDescriptionForArticle(String number) {
    final descriptions = {'100': 'Definitions of terms used throughout the NEC.', '210': 'Branch circuit requirements and ratings.', '250': 'Grounding and bonding requirements.'};
    return descriptions[number] ?? 'NEC article requirements.';
  }
}
