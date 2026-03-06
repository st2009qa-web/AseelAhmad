import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


void main() {
  runApp(const JordanTourismApp());
}

class JordanTourismApp extends StatelessWidget {
  const JordanTourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سياحة الأردن',
      // دعم اللغة العربية والاتجاه من اليمين لليسار
      locale: const Locale('ar', 'JO'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto', // يمكنك تغييرها لخط عربي لاحقاً
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double _userRating = 0;

  final List<Map<String, String>> locations = [
    {
      'name': 'البتراء',
      'desc': 'واحدة من عجائب الدنيا السبع وتسمى المدينة الوردية.',
      'image': 'assets/images/petra.jpeg' // رابط تجريبي
    },
    {
      'name': 'وادي رم',
      'desc': 'يُعرف بوادي القمر ويتميز بجمال صحرائه وتشكيلاته الصخرية.',
      'image': 'assets/images/wadi-rum.webp' // رابط تجريبي
    },
    {
      'name': 'جرش',
      'desc': 'تعد من أكبر المواقع الرومانية المحفوظة في العالم.',
      'image': 'assets/images/jarash.jpg' // رابط تجريبي
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اكتشف الأردن'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- قسم الفيديو التعريفي ---
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('فيديو تعريفي عن الأردن', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 220,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('assets/images/jarash.jpg'), // صورة خلفية للفيديو
                  fit: BoxFit.cover,
                  opacity: 0.6,
                ),
              ),
              child: const Center(
                child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),

            // --- قائمة المعالم السياحية مع صور ---
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('أبرز الوجهات السياحية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      // مكان الصورة لكل معلم
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          locations[index]['image']!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListTile(
                        title: Text(locations[index]['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(locations[index]['desc']!),
                        leading: const Icon(Icons.location_on, color: Colors.redAccent),
                      ),
                    ],
                  ),
                );
              },
            ),

            const Divider(),
            // --- نظام تقييم التطبيق ---
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('قيم تجربة التطبيق:', style: TextStyle(fontSize: 16)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _userRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 35,
                  ),
                  onPressed: () {
                    setState(() {
                      _userRating = index + 1.0;
                    });
                    if (_userRating >= 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('شكراً لتقييمك الرائع! 👏'))
                      );
                    }
                  },
                );
              }),
            ),
            
            const SizedBox(height: 20),
            // --- زر الانتقال للاختبار ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizScreen())),
                icon: const Icon(Icons.quiz),
                label: const Text('ابدأ اختبار معلوماتك عن الأردن'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// (شاشة الاختبار بقيت كما هي مع تحسين طفيف في المظهر)
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _quizData = [
    {'q': 'في أي محافظة تقع البتراء؟', 'a': ['معان', 'عمان', 'اربد'], 'correct': 0},
    {'q': 'ماذا يلقب وادي رم؟', 'a': ['وادي القمر', 'وادي الشمس', 'وادي النجوم'], 'correct': 0},
    {'q': 'أين تقع قلعة عجلون؟', 'a': ['عجلون', 'الكرك', 'الطفيلة'], 'correct': 0},
    {'q': 'أي مدينة تشتهر بالآثار الرومانية؟', 'a': ['جرش', 'العقبة', 'الزرقاء'], 'correct': 0},
    {'q': 'ما هو أدنى نقطة على سطح الأرض في الأردن؟', 'a': ['البحر الميت', 'خليج العقبة', 'نهر الأردن'], 'correct': 0},
  ];

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _quizData[_currentQuestionIndex]['correct']) {
      _score++;
    }

    setState(() {
      if (_currentQuestionIndex < _quizData.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('النتيجة النهائية', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 60),
            const SizedBox(height: 10),
            Text('لقد أجبت بشكل صحيح على $_score من أصل ${_quizData.length}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختبار معلوماتك')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(value: (_currentQuestionIndex + 1) / _quizData.length),
            const SizedBox(height: 20),
            Text('سؤال ${_currentQuestionIndex + 1}:', style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 10),
            Text(_quizData[_currentQuestionIndex]['q'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ...(_quizData[_currentQuestionIndex]['a'] as List<String>).asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  onPressed: () => _answerQuestion(entry.key),
                  child: Text(entry.value, style: const TextStyle(fontSize: 18)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;
  
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/videos/jordan.mp4")
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: controller.value.isInitialized
              ? AspectRatio(
                  child: VideoPlayer(controller),
                  aspectRatio: controller.value.aspectRatio,
                )
              : Text("تعذر التشغيل"),
        ),
        Center(
          child: IconButton(
            style: ElevatedButton.styleFrom(shape: CircleBorder()),
            onPressed: () async {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            },
            icon: controller.value.isPlaying
                ? Icon(Icons.pause)
                : Icon(Icons.play_arrow),
          ),
        ),
      ],
    );
  }
}
