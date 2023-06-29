import '../../features/period_tracker/screens/period_tracker_screen.dart';
import '../../features/shopping/screens/shopping_home_screen.dart';

String uri = 'http://127.0.0.1:5001/pro-luna/us-central1';

class Constants {
  static const logoPath = 'assets/images/logo.png';
  static const loginEmotePath = 'assets/images/loginEmote.png';
  static const googlePath = 'assets/images/google.png';

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';

  static const tabWidgets = [
    PeriodTrackerScreen(),
    ShoppingHomeScreen(),
  ];

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> articels = [
    {
      'image':
          'https://kidshealth.org/content/dam/patientinstructions/en/images/menstrual_a_enIL.jpg',
      'title':'All about periods(for teen)',
      'url':'https://kidshealth.org/en/teens/menstruation.html',
    },
    {
      'image':
          'https://domf5oio6qrcr.cloudfront.net/medialibrary/10827/7f24e44d-cda1-4c54-9d1c-ea3daeff265c.jpg',
      'title':'Period equity: What it is and why it matters',
      'url':'https://www.health.harvard.edu/blog/period-equity-what-is-it-why-does-it-matter-202106012473',
    },
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Period Products',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Pain Relief',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Intimate Hygiene',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Custom Kits',
      'image': 'assets/images/books.jpeg',
    },
  ];
}
