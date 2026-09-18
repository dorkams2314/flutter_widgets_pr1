import 'package:flutter/material.dart';

import 'productivity_screens.dart';

const _teal = Color(0xFF0AA6A5);
const _softTeal = Color(0xFFE8FAF8);
const _ink = Color(0xFF171717);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _continue(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const MeditateScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _teal,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: SizedBox(
              width: constraints.maxWidth > 520 ? 420 : constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const Text(
                    'medinow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Meditate With Us!',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  const SizedBox(height: 54),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      children: [
                        _WelcomeButton(
                          label: 'Sign in with Apple',
                          backgroundColor: Colors.white,
                          onPressed: () => _continue(context),
                        ),
                        const SizedBox(height: 13),
                        _WelcomeButton(
                          label: 'Continue with Email or Phone',
                          backgroundColor: const Color(0xFFC9F4F4),
                          onPressed: () => _continue(context),
                        ),
                        const SizedBox(height: 17),
                        TextButton(
                          onPressed: () => _continue(context),
                          child: const Text(
                            'Continue With Google',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 255,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomPaint(painter: _WelcomeIllustrationPainter()),
                        Image(
                          image: AssetImage(
                            'assets/images/welcome-illustration.png',
                          ),
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomCenter,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeButton extends StatelessWidget {
  const _WelcomeButton({
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 51,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: _ink,
          elevation: 0,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}

class MeditateScreen extends StatefulWidget {
  const MeditateScreen({super.key});

  @override
  State<MeditateScreen> createState() => _MeditateScreenState();
}

class _MeditateScreenState extends State<MeditateScreen> {
  int _category = 0;
  static const _categories = [
    'All',
    'Bible In a Year',
    'Dailies',
    'Minutes',
    'November',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Meditate',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search_rounded, size: 28),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const WeeklyPlannerScreen(),
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xFFFFD7C2),
                            child: Text(
                              'DS',
                              style: TextStyle(
                                color: Color(0xFF67463C),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 45,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) => ChoiceChip(
                        label: Text(_categories[index]),
                        selected: _category == index,
                        showCheckmark: false,
                        side: BorderSide.none,
                        labelStyle: TextStyle(
                          color: _category == index ? Colors.white : _teal,
                          fontSize: 12,
                        ),
                        backgroundColor: _softTeal,
                        selectedColor: _teal,
                        onSelected: (_) => setState(() => _category = index),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _FeaturedSession(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const SessionDetailsScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          Expanded(
                            child: _MeditationCard(
                              kind: _ArtworkKind.sleep,
                              color: Color(0xFFFA9637),
                              title: 'The Sleep Hour',
                              author: 'Ashma Mukherjee',
                              minutes: '3 Sessions',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _MeditationCard(
                              kind: _ArtworkKind.moon,
                              color: Color(0xFFF8CF4D),
                              title: 'Easy on the Mission',
                              author: 'Peter Mach',
                              minutes: '5 minutes',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Row(
                        children: [
                          Expanded(
                            child: _MeditationCard(
                              kind: _ArtworkKind.sun,
                              color: Color(0xFF378DE8),
                              title: 'Relax with Me',
                              author: 'Amanda James',
                              minutes: '4 Sessions',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _MeditationCard(
                              kind: _ArtworkKind.cloud,
                              color: Color(0xFF13A7A4),
                              title: 'Sun and Energy',
                              author: 'Michael Flu',
                              minutes: '5 minutes',
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedSession extends StatelessWidget {
  const _FeaturedSession({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AspectRatio(
            aspectRatio: 1.86,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              child: ColoredBox(
                color: Color(0xFFF8CC4B),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomPaint(painter: _SunMoonPainter()),
                    Image(
                      image: AssetImage('assets/images/song-of-moon.png'),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'A Song of Moon',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 5),
          const Text('Start with the basics', style: TextStyle(fontSize: 15)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.favorite_border_rounded, size: 19),
              const SizedBox(width: 5),
              Text(
                '9 Sessions',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              const Spacer(),
              Text(
                'Start',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              const Icon(Icons.chevron_right_rounded, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

enum _ArtworkKind { sleep, moon, sun, cloud }

class _MeditationCard extends StatelessWidget {
  const _MeditationCard({
    required this.kind,
    required this.color,
    required this.title,
    required this.author,
    required this.minutes,
  });

  final _ArtworkKind kind;
  final Color color;
  final String title;
  final String author;
  final String minutes;

  String get _asset => switch (kind) {
    _ArtworkKind.sleep => 'assets/images/sleep-hour.png',
    _ArtworkKind.moon => 'assets/images/easy-mission.png',
    _ArtworkKind.sun => 'assets/images/song-of-moon.png',
    _ArtworkKind.cloud => 'assets/images/mind-deep-relax.png',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.55,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: ColoredBox(
              color: color,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(painter: _MiniArtworkPainter(kind)),
                  Image(image: AssetImage(_asset), fit: BoxFit.cover),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        ),
        const SizedBox(height: 3),
        Text(
          author,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.favorite_border_rounded, size: 14),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                minutes,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
              ),
            ),
            Text(
              'Start ›',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}

class SessionDetailsScreen extends StatefulWidget {
  const SessionDetailsScreen({super.key});

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  bool _playing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const AspectRatio(
                  aspectRatio: 1.55,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    child: ColoredBox(
                      color: Color(0xFFF7CF4D),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CustomPaint(painter: _LakePainter()),
                          Image(
                            image: AssetImage(
                              'assets/images/mind-deep-relax.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Peter Mach',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Mind Deep Relax',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Text(
                  'Join the Community as we prepare over 33 days to relax and feel joy with the mind and happiness session across the World.',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 15,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: () => setState(() => _playing = !_playing),
                    icon: Icon(
                      _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    ),
                    label: Text(
                      _playing ? 'Pause Session' : 'Play Next Session',
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: _teal,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const _SessionRow(
                  color: Color(0xFF398DE8),
                  title: 'Sweet Memories',
                  subtitle: 'December 29 Pre-Launch',
                ),
                const Divider(height: 1),
                const _SessionRow(
                  color: _teal,
                  title: 'A Day Dream',
                  subtitle: 'December 29 Pre-Launch',
                ),
                const Divider(height: 1),
                const _SessionRow(
                  color: Color(0xFFF49A37),
                  title: 'Mind Explore',
                  subtitle: 'December 29 Pre-Launch',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({
    required this.color,
    required this.title,
    required this.subtitle,
  });
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(Icons.play_arrow_outlined, color: Colors.white),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_horiz_rounded, color: Colors.grey),
        ],
      ),
    );
  }
}

class _WelcomeIllustrationPainter extends CustomPainter {
  const _WelcomeIllustrationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final dark = Paint()..color = const Color(0xFF087D80);
    final pale = Paint()..color = const Color(0xFF75D7CF);
    final light = Paint()..color = const Color(0xFFA8E7DE);
    final skin = Paint()..color = const Color(0xFFF7F3E8);
    final line = Paint()
      ..color = const Color(0xFF193F47)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    canvas.drawOval(
      Rect.fromLTWH(-20, size.height - 38, size.width + 40, 58),
      dark,
    );
    for (final item in [
      (Offset(36, 205), -0.5, light),
      (Offset(70, 190), -0.15, pale),
      (Offset(size.width - 55, 198), 0.4, light),
      (Offset(size.width - 93, 188), 0.1, pale),
    ]) {
      canvas.save();
      canvas.translate(item.$1.dx, item.$1.dy);
      canvas.rotate(item.$2);
      canvas.drawOval(const Rect.fromLTWH(-13, -50, 26, 70), item.$3);
      canvas.restore();
    }

    final center = Offset(size.width * 0.5, 118);
    canvas.drawCircle(center.translate(0, -47), 22, skin);
    canvas.drawPath(
      Path()
        ..moveTo(center.dx - 24, center.dy - 68)
        ..quadraticBezierTo(
          center.dx,
          center.dy - 87,
          center.dx + 19,
          center.dy - 65,
        )
        ..lineTo(center.dx + 8, center.dy - 55)
        ..quadraticBezierTo(
          center.dx - 8,
          center.dy - 66,
          center.dx - 24,
          center.dy - 58,
        )
        ..close(),
      dark,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 84, height: 92),
        const Radius.circular(36),
      ),
      skin,
    );
    canvas.drawPath(
      Path()
        ..moveTo(center.dx - 34, center.dy - 4)
        ..quadraticBezierTo(
          center.dx - 3,
          center.dy + 18,
          center.dx + 34,
          center.dy - 4,
        )
        ..moveTo(center.dx - 31, center.dy + 7)
        ..quadraticBezierTo(
          center.dx,
          center.dy + 34,
          center.dx + 31,
          center.dy + 7,
        ),
      line,
    );
    canvas.drawCircle(center.translate(-4, 9), 4, dark);
    canvas.drawPath(
      Path()
        ..moveTo(center.dx - 38, center.dy + 43)
        ..quadraticBezierTo(
          center.dx - 85,
          center.dy + 72,
          center.dx - 105,
          center.dy + 96,
        )
        ..quadraticBezierTo(
          center.dx - 31,
          center.dy + 92,
          center.dx,
          center.dy + 64,
        )
        ..quadraticBezierTo(
          center.dx + 31,
          center.dy + 92,
          center.dx + 105,
          center.dy + 96,
        )
        ..quadraticBezierTo(
          center.dx + 85,
          center.dy + 72,
          center.dx + 38,
          center.dy + 43,
        ),
      skin,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SunMoonPainter extends CustomPainter {
  const _SunMoonPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.48, size.height * 0.51);
    final sun = Paint()..color = const Color(0xFFF0604E);
    final rays = Paint()
      ..color = const Color(0xFFF0604E)
      ..strokeWidth = 5;
    for (var i = 0; i < 16; i++) {
      final angle = i * 3.14159 / 8;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      canvas.drawLine(const Offset(66, 0), const Offset(86, 0), rays);
      canvas.restore();
    }
    canvas.drawCircle(center, 63, sun);
    canvas.drawCircle(
      center.translate(48, 0),
      66,
      Paint()..color = const Color(0xFF263D50),
    );
    canvas.drawCircle(
      center.translate(24, -3),
      55,
      Paint()..color = const Color(0xFFF8CC4B),
    );
    final face = Paint()
      ..color = const Color(0xFF773D38)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center.translate(-17, -4), radius: 9),
      0.2,
      2.4,
      false,
      face,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center.translate(18, -4), radius: 9),
      0.5,
      2.4,
      false,
      face,
    );
    canvas.drawArc(
      Rect.fromCenter(center: center.translate(0, 19), width: 30, height: 18),
      0.15,
      2.8,
      false,
      face,
    );
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.1, size.height * 0.72, 70, 22),
      Paint()..color = Colors.white.withValues(alpha: 0.85),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiniArtworkPainter extends CustomPainter {
  const _MiniArtworkPainter(this.kind);
  final _ArtworkKind kind;

  @override
  void paint(Canvas canvas, Size size) {
    final cream = Paint()..color = const Color(0xFFFFF2C8);
    if (kind == _ArtworkKind.moon) {
      canvas.drawCircle(
        Offset(size.width * 0.62, size.height * 0.5),
        size.height * 0.28,
        cream,
      );
      canvas.drawCircle(
        Offset(size.width * 0.69, size.height * 0.42),
        size.height * 0.28,
        Paint()..color = const Color(0xFF4E5664),
      );
      canvas.drawOval(
        Rect.fromLTWH(
          size.width * 0.1,
          size.height * 0.27,
          size.width * 0.42,
          size.height * 0.24,
        ),
        Paint()..color = Colors.white.withValues(alpha: 0.9),
      );
    } else if (kind == _ArtworkKind.sun) {
      canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.52),
        size.height * 0.29,
        Paint()..color = const Color(0xFFFFCF3F),
      );
      for (var i = 0; i < 12; i++) {
        canvas.save();
        canvas.translate(size.width * 0.5, size.height * 0.52);
        canvas.rotate(i * 3.14159 / 6);
        canvas.drawLine(
          Offset(size.height * 0.32, 0),
          Offset(size.height * 0.42, 0),
          Paint()
            ..color = const Color(0xFFFFCF3F)
            ..strokeWidth = 3,
        );
        canvas.restore();
      }
    } else {
      canvas.drawOval(
        Rect.fromLTWH(
          size.width * 0.16,
          size.height * 0.38,
          size.width * 0.43,
          size.height * 0.18,
        ),
        cream,
      );
      canvas.drawCircle(
        Offset(size.width * 0.4, size.height * 0.39),
        size.height * 0.12,
        cream,
      );
      if (kind == _ArtworkKind.cloud) {
        canvas.drawCircle(
          Offset(size.width * 0.78, size.height * 0.25),
          4,
          cream,
        );
        canvas.drawCircle(
          Offset(size.width * 0.83, size.height * 0.2),
          2.5,
          cream,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MiniArtworkPainter oldDelegate) =>
      oldDelegate.kind != kind;
}

class _LakePainter extends CustomPainter {
  const _LakePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final navy = Paint()..color = const Color(0xFF344653);
    final white = Paint()..color = const Color(0xFFF7F5ED);
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height * 0.52)
        ..quadraticBezierTo(
          size.width * 0.2,
          size.height * 0.42,
          size.width * 0.38,
          size.height * 0.52,
        )
        ..quadraticBezierTo(
          size.width * 0.62,
          size.height * 0.62,
          size.width,
          size.height * 0.48,
        )
        ..lineTo(size.width, size.height * 0.58)
        ..lineTo(0, size.height * 0.58)
        ..close(),
      white,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.58, size.height * 0.5)
        ..lineTo(size.width * 0.75, size.height * 0.35)
        ..lineTo(size.width, size.height * 0.45)
        ..lineTo(size.width, size.height * 0.57)
        ..close(),
      navy,
    );
    final pier = Path()
      ..moveTo(size.width * 0.36, size.height)
      ..lineTo(size.width * 0.45, size.height * 0.62)
      ..lineTo(size.width * 0.58, size.height * 0.62)
      ..lineTo(size.width * 0.69, size.height)
      ..close();
    canvas.drawPath(pier, navy);
    final personX = size.width * 0.515;
    canvas.drawCircle(Offset(personX, size.height * 0.25), 10, navy);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(personX - 17, size.height * 0.29, 34, 72),
        const Radius.circular(12),
      ),
      white,
    );
    canvas.drawLine(
      Offset(personX - 8, size.height * 0.58),
      Offset(personX - 12, size.height * 0.76),
      navy..strokeWidth = 6,
    );
    canvas.drawLine(
      Offset(personX + 8, size.height * 0.58),
      Offset(personX + 12, size.height * 0.76),
      navy,
    );
    for (final x in [0.1, 0.22, 0.81, 0.9]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(size.width * x, size.height * 0.18),
          width: 34,
          height: 8,
        ),
        white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
