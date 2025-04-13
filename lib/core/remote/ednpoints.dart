
class Endpoints {
  static String prayingTimes =
      '/calendar/${DateTime.now().year}/${DateTime.now().month}';
  static String nextPrayTime = '/nextPrayer/${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

}
