import '../pages/home_page.dart'; // DayPlan & Place modelini kullanıyoruz

/// Gemini çıktısını **Markdown** formatında alır ve List<DayPlan> döndürür.
/// Model çıktısının şu şablonu koruduğundan emin olun:
///
/// **Day 1: Theme**
/// * **Place (Duration):** Description *Tip: Tip text*
List<DayPlan> parseMarkdownPlan(String text) {
  final List<DayPlan> plans = [];
  final RegExp dayHeader = RegExp(r'^\*\*Day (\d+):.*\*\*');
  final RegExp placeLine =
      RegExp(r'^\*\s\*\*(.+)\s\((.+)\):\*\s(.+?)\s\*Tip:\s(.+)\*');

  String? currentLabel;
  List<Place> currentPlaces = [];

  for (final raw in text.split('\n')) {
    final line = raw.trim();

    if (dayHeader.hasMatch(line)) {
      // önceki günü ekle
      if (currentLabel != null) {
        plans.add(DayPlan(dayLabel: currentLabel, places: currentPlaces));
      }
      currentLabel = line.replaceAll('**', '');
      currentPlaces = [];
    } else if (placeLine.hasMatch(line)) {
      final m = placeLine.firstMatch(line)!;
      currentPlaces.add(Place(
        name: m.group(1)!.trim(),
        duration: m.group(2)!.trim(),
        description: m.group(3)!.trim(),
        tip: m.group(4)!.trim(),
      ));
    }
  }
  // son günü ekle
  if (currentLabel != null) {
    plans.add(DayPlan(dayLabel: currentLabel, places: currentPlaces));
  }
  return plans;
}
