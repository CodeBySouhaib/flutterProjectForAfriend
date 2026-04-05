import 'dart:math';
import 'package:flutter/material.dart';
import 'package:orm_risk_assessment/ui/home_page.dart';
import 'package:video_player/video_player.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  LANDING PAGE
// ─────────────────────────────────────────────────────────────────────────────
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  int? _selectedLetterIndex;

  static const _helicopterItems = [
    _HelicopterItem(
      letter: 'H', title: 'Human Factor',
      subtitle: 'Fatigue, stress, pilot health',
      accentColor: Color(0xFF4169E1), icon: Icons.person_outline,
      definition:
          'Evaluates the physical and mental state of crew members. Covers fatigue levels, stress, illness, medication, emotional state, and overconfidence. A degraded human factor significantly increases operational risk.',
    ),
    _HelicopterItem(
      letter: 'E', title: 'Environment',
      subtitle: 'Weather, visibility, terrain',
      accentColor: Color(0xFF6495ED), icon: Icons.cloud_outlined,
      definition:
          'Assesses all environmental conditions: weather (CB, wind, ceiling, visibility, turbulence), natural light (sun/moon position), landing zones, obstacles, brownout, birds, and laser hazards.',
    ),
    _HelicopterItem(
      letter: 'L', title: 'Leadership & Supervision',
      subtitle: 'Command, decision-making',
      accentColor: Color(0xFF1E90FF), icon: Icons.military_tech_outlined,
      definition:
          'Examines the quality of command and supervision. Includes clarity of expectations, supervision presence, and proper authority delegation during mission planning and execution.',
    ),
    _HelicopterItem(
      letter: 'I', title: 'Interface',
      subtitle: 'Human-machine interaction',
      accentColor: Color(0xFF00BFFF), icon: Icons.settings_input_composite_outlined,
      definition:
          'Covers crew–cockpit interaction: ergonomics, cockpit setup, familiarity with helicopter systems and displays, proficiency with Syntham 5000, Foreflight, and SMS tracking.',
    ),
    _HelicopterItem(
      letter: 'C', title: 'Communication',
      subtitle: 'Crew / ATC coordination',
      accentColor: Color(0xFF87CEEB), icon: Icons.radio_outlined,
      definition:
          'Assesses external (ATC, other aircraft, emergency calls) and internal (CRM, standard calls, priorities) communications. Identifies risks from missed calls or unclear instructions.',
    ),
    _HelicopterItem(
      letter: 'O', title: 'Operation / Mission',
      subtitle: 'Mission type, complexity',
      accentColor: Color(0xFF4682B4), icon: Icons.flight_outlined,
      definition:
          'Evaluates mission-specific risks: type (NVG, formation, terrain flight, MTF, emergency), high-workload maneuvers, congested training areas, and mid-flight pilot changeovers.',
    ),
    _HelicopterItem(
      letter: 'P', title: 'Planning',
      subtitle: 'Preparation, briefing',
      accentColor: Color(0xFF5F9EA0), icon: Icons.map_outlined,
      definition:
          'Reviews mission preparation: planning time, ANAMs/NOAMs consultation, weight & balance, fuel planning, refueling availability, and coordination with transit stations.',
    ),
    _HelicopterItem(
      letter: 'T', title: 'Task Proficiency',
      subtitle: 'Experience, training currency',
      accentColor: Color(0xFF00CED1), icon: Icons.checklist_outlined,
      definition:
          'Evaluates currency of all crew: PIC/Instructor, copilot, student pilot skill, crewmember recency, medical certificates, and crewchief proficiency.',
    ),
    _HelicopterItem(
      letter: 'E', title: 'Equipment',
      subtitle: 'Helicopter condition (Écureuil)',
      accentColor: Color(0xFF20B2AA), icon: Icons.construction_outlined,
      definition:
          'Assesses aircraft state: discrepancies, faulty components, deferred maintenance, available flight hours until next service, and recurrent failures.',
    ),
    _HelicopterItem(
      letter: 'R', title: 'Risk Assessment',
      subtitle: 'Global risk evaluation',
      accentColor: Color(0xFF48D1CC), icon: Icons.shield_outlined,
      definition:
          'Final ORM synthesis across all factors. Considers SOP deviations, SPINs deviations, and unnecessary risk acceptance. Determines if the mission proceeds, is modified, or cancelled.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080838),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeroVideo()),
                SliverToBoxAdapter(child: _buildHelicopterSection()),
                SliverToBoxAdapter(child: _buildFooter()),
              ],
            ),
          ),
          _buildStartButton(context),
        ],
      ),
    );
  }

  // ── HERO VIDEO ──────────────────────────────────────────────────────────────
  Widget _buildHeroVideo() {
    return SizedBox(
      height: 270,
      child: Stack(
        children: [
          Positioned.fill(
            child: _HeroVideoWidget(),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xFF080838)],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xCC080838),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    _heroBadge('ORM', large: true),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Operational Risk Management',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 11,
                          fontFamily: 'Courier New',
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 6),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _heroBadge('31 UA'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 22,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'HELICOPTER',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Courier New',
                    letterSpacing: 7,
                    shadows: const [
                      Shadow(color: Colors.black, blurRadius: 8),
                      Shadow(color: Colors.black, blurRadius: 8),
                      Shadow(color: Color(0xFF4169E1), blurRadius: 14),
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Risk Assessment Model  ·  tap a letter to explore',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11,
                    fontFamily: 'Courier New',
                    letterSpacing: 0.4,
                    shadows: const [
                      Shadow(color: Colors.black, blurRadius: 6),
                      Shadow(color: Colors.black, blurRadius: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroBadge(String text, {bool large = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xEE080838),
        border: Border.all(color: const Color(0xFF4169E1), width: 1.2),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFFFFFFFF),
          fontSize: large ? 16 : 11,
          fontWeight: large ? FontWeight.w900 : FontWeight.normal,
          fontFamily: 'Courier New',
          letterSpacing: 2,
        ),
      ),
    );
  }

  // ── HELICOPTER SECTION ──────────────────────────────────────────────────────
  Widget _buildHelicopterSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 8),
      child: Column(
        children: [
          // ── Divider label ──
          Row(
            children: [
              Expanded(
                child: Divider(color: const Color(0xFF111154), thickness: 1),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'HELICOPTER MODEL',
                  style: TextStyle(
                    color: Color(0xFF191970),
                    fontSize: 9,
                    fontFamily: 'Courier New',
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              Expanded(
                child: Divider(color: const Color(0xFF111154), thickness: 1),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Letters row ──
          _buildLettersRow(),

          const SizedBox(height: 14),

          // ── Selected title display ──
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.15),
                  end: Offset.zero,
                ).animate(anim),
                child: child,
              ),
            ),
            child: _selectedLetterIndex != null
                ? _buildSelectedTitle()
                : const SizedBox(height: 56, key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }

  Widget _buildLettersRow() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 7,
      runSpacing: 7,
      children: List.generate(_helicopterItems.length, (i) {
        final item = _helicopterItems[i];
        final isSelected = _selectedLetterIndex == i;

        return GestureDetector(
          onTap: () => setState(() {
            _selectedLetterIndex = _selectedLetterIndex == i ? null : i;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? item.accentColor.withOpacity(0.18)
                  : const Color(0xFF080838),
              border: Border.all(
                color: isSelected
                    ? item.accentColor
                    : const Color(0xFF111154),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: item.accentColor.withOpacity(0.35),
                        blurRadius: 10,
                        spreadRadius: 1,
                      )
                    ]
                  : null,
            ),
            child: Text(
              item.letter,
              style: TextStyle(
                color: isSelected
                    ? item.accentColor
                    : const Color(0xFF4169E1),
                fontSize: 22,
                fontWeight: FontWeight.w900,
                fontFamily: 'Courier New',
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSelectedTitle() {
    final item = _helicopterItems[_selectedLetterIndex!];
    return Container(
      key: ValueKey(_selectedLetterIndex),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: item.accentColor.withOpacity(0.07),
        border: Border(
          left: BorderSide(color: item.accentColor, width: 3),
          bottom: BorderSide(color: item.accentColor.withOpacity(0.25), width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(item.icon, color: item.accentColor, size: 20),
          const SizedBox(width: 12),
          Text(
            item.title.toUpperCase(),
            style: TextStyle(
              color: item.accentColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: 'Courier New',
              letterSpacing: 1.8,
              shadows: [
                Shadow(color: item.accentColor.withOpacity(0.5), blurRadius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── FOOTER ──────────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
        child: Column(children: const [
        Text('ORM  | 31ème unité aérienne',
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11,
                fontFamily: 'Courier New', letterSpacing: 1.5)),
        SizedBox(height: 4),
        Text('© 2026 Tous droits réservés',
            style: TextStyle(color: Color(0xFF4169E1), fontSize: 10,
                fontFamily: 'Courier New')),
      ]),
    );
  }

  // ── START BUTTON ─────────────────────────────────────────────────────────────
  Widget _buildStartButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 30),
      color: const Color(0xFF080838),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const HomePage(),
              transitionsBuilder: (_, anim, __, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: const Duration(milliseconds: 450),
            ),
          ),
          icon: const Icon(Icons.security, size: 20),
          label: const Text(
            'START RISK ASSESSMENT',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                letterSpacing: 2.5, fontFamily: 'Courier New'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF191970),
            foregroundColor: const Color(0xFFFFFFFF),
            side: const BorderSide(color: Color(0xFF4169E1), width: 1.5),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  BIG HELICOPTER WIDGET  (full-width, animated)
// ─────────────────────────────────────────────────────────────────────────────
class _BigHelicopterWidget extends StatefulWidget {
  @override
  State<_BigHelicopterWidget> createState() => _BigHelicopterWidgetState();
}

class _BigHelicopterWidgetState extends State<_BigHelicopterWidget>
    with TickerProviderStateMixin {
  late AnimationController _hoverCtrl;
  late Animation<double> _hoverAnim;

  late AnimationController _swayCtrl;
  late Animation<double> _swayAnim;

  late AnimationController _entryCtrl;
  late Animation<double> _entryAnim;

  late AnimationController _rotorCtrl;

  @override
  void initState() {
    super.initState();

    _hoverCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
    _hoverAnim = CurvedAnimation(parent: _hoverCtrl, curve: Curves.easeInOut);

    _swayCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3900),
    )..repeat(reverse: true);
    _swayAnim = CurvedAnimation(parent: _swayCtrl, curve: Curves.easeInOut);

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _entryAnim =
        CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic);
    _entryCtrl.forward();

    _rotorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    )..repeat();
  }

  @override
  void dispose() {
    _hoverCtrl.dispose();
    _swayCtrl.dispose();
    _entryCtrl.dispose();
    _rotorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = constraints.maxHeight;

      // Large size — ~80% of available width
      final heliW = w * 0.80;
      final heliH = heliW * 0.60;

      final baseX = w * 0.5 - heliW * 0.5;
      final baseY = h * 0.5 - heliH * 0.5;

      return AnimatedBuilder(
        animation: Listenable.merge(
            [_hoverAnim, _swayAnim, _entryAnim, _rotorCtrl]),
        builder: (_, __) {
          final dy = -12 + _hoverAnim.value * 24;
          final dx = -10 + _swayAnim.value * 20;
          final tiltRad = (-2.5 + _swayAnim.value * 5) * pi / 180;
          final entryDx = (1 - _entryAnim.value) * 160;
          final entryOpacity = _entryAnim.value.clamp(0.0, 1.0);

          final finalX = baseX + dx + entryDx;
          final finalY = baseY + dy;

          return Stack(
            children: [
              // Soft ground glow
              Positioned(
                left: finalX + heliW * 0.1,
                top: baseY + heliH * 0.95,
                child: Container(
                  width: heliW * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4169E1).withOpacity(0.08),
                        blurRadius: 24,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),

              // Helicopter
              Positioned(
                left: finalX,
                top: finalY,
                child: Opacity(
                  opacity: entryOpacity,
                  child: Transform.rotate(
                    angle: tiltRad,
                    child: SizedBox(
                      width: heliW,
                      height: heliH,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          // Rotor blur ring
                          Positioned(
                            top: 4,
                            left: heliW * 0.12,
                            child: Transform.rotate(
                              angle: _rotorCtrl.value * 2 * pi,
                              child: Container(
                                width: heliW * 0.76,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.22),
                                      Colors.white.withOpacity(0.04),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 0.6, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Helicopter PNG
                          Image.asset(
                            'assets/images/helicopter.png',
                            width: heliW,
                            height: heliH,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => _HelicopterPlaceholder(
                              width: heliW,
                              height: heliH,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  HELICOPTER PLACEHOLDER
// ─────────────────────────────────────────────────────────────────────────────
class _HelicopterPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  const _HelicopterPlaceholder({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flight, color: Colors.white.withOpacity(0.25), size: 64),
          const SizedBox(height: 6),
          Text(
            'Add assets/images/helicopter.png',
            style: TextStyle(
              color: Colors.white.withOpacity(0.18),
              fontSize: 10,
              fontFamily: 'Courier New',
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  RADAR WIDGET
// ─────────────────────────────────────────────────────────────────────────────
class _RadarWidget extends StatefulWidget {
  @override
  State<_RadarWidget> createState() => _RadarWidgetState();
}

class _RadarWidgetState extends State<_RadarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _radarController;
  final List<_Blip> _blips = [];
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();

    for (int i = 0; i < 7; i++) {
      _blips.add(_randomBlip());
    }
    _radarController.addListener(_maybeTriggerBlip);
  }

  _Blip _randomBlip() => _Blip(
        angle: _rng.nextDouble() * 2 * pi,
        radius: 0.18 + _rng.nextDouble() * 0.72,
        birthAngle: _rng.nextDouble() * 2 * pi,
        size: 2.0 + _rng.nextDouble() * 3.0,
      );

  double _lastSweep = 0;
  void _maybeTriggerBlip() {
    final sweep = (_radarController.value * 2 * pi) % (2 * pi);
    if (_lastSweep > sweep && _rng.nextDouble() < 0.6) {
      final idx = _rng.nextInt(_blips.length);
      setState(() {
        _blips[idx] = _randomBlip()..birthAngle = sweep;
      });
    }
    _lastSweep = sweep;
  }

  @override
  void dispose() {
    _radarController.removeListener(_maybeTriggerBlip);
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _radarController,
      builder: (_, __) => CustomPaint(
        painter: _RadarPainter(
          sweepFraction: _radarController.value,
          blips: _blips,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  RADAR PAINTER
// ─────────────────────────────────────────────────────────────────────────────
class _RadarPainter extends CustomPainter {
  final double sweepFraction;
  final List<_Blip> blips;

  _RadarPainter({required this.sweepFraction, required this.blips});

  static const _sweepColor = Color(0xFF4169E1);
  static const _blipColor  = Color(0xFF6495ED);
  static const _ringColor  = Color(0xFF111154);
  static const _crossColor = Color(0xFF191970);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.52;
    final maxR = min(size.width, size.height) * 0.70;
    final sweepAngle = sweepFraction * 2 * pi - pi / 2;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = const Color(0xFF080838));

    final crossPaint = Paint()..color = _crossColor..strokeWidth = 0.5;
    canvas.drawLine(Offset(cx, cy - maxR), Offset(cx, cy + maxR), crossPaint);
    canvas.drawLine(Offset(cx - maxR, cy), Offset(cx + maxR, cy), crossPaint);
    canvas.drawLine(Offset(cx - maxR * .71, cy - maxR * .71),
        Offset(cx + maxR * .71, cy + maxR * .71), crossPaint);
    canvas.drawLine(Offset(cx + maxR * .71, cy - maxR * .71),
        Offset(cx - maxR * .71, cy + maxR * .71), crossPaint);

    final ringPaint = Paint()
      ..color = _ringColor..style = PaintingStyle.stroke..strokeWidth = 0.8;
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(Offset(cx, cy), maxR * i / 4, ringPaint);
    }

    final trailRect = Rect.fromCircle(center: Offset(cx, cy), radius: maxR);
    const trailAngle = pi * 0.85;
    for (int i = 0; i < 40; i++) {
      final t = i / 40;
      final path = Path()
        ..moveTo(cx, cy)
        ..arcTo(trailRect, sweepAngle - trailAngle * (i + 1) / 40,
            trailAngle / 40, false)
        ..close();
      canvas.drawPath(path,
          Paint()..color = _sweepColor.withOpacity((1 - t) * 0.42));
    }

    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + maxR * cos(sweepAngle), cy + maxR * sin(sweepAngle)),
      Paint()
        ..color = _sweepColor.withOpacity(0.95)
        ..strokeWidth = 1.6..strokeCap = StrokeCap.round,
    );

    canvas.drawCircle(
      Offset(cx + maxR * cos(sweepAngle), cy + maxR * sin(sweepAngle)),
      5,
      Paint()
        ..color = _sweepColor.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    for (final blip in blips) {
      final diff = _angDiff(sweepAngle, blip.birthAngle - pi / 2);
      final age = diff / (2 * pi);
      if (age > 0.92) continue;
      final opacity = (1.0 - age / 0.92).clamp(0.0, 1.0);
      final bx = cx + maxR * blip.radius * cos(blip.angle);
      final by = cy + maxR * blip.radius * sin(blip.angle);
      canvas.drawCircle(Offset(bx, by), blip.size * 2.2,
          Paint()
            ..color = _blipColor.withOpacity(opacity * 0.25)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4));
      canvas.drawCircle(Offset(bx, by), blip.size * 0.7,
          Paint()..color = _blipColor.withOpacity(opacity * 0.9));
    }

    canvas.drawCircle(Offset(cx, cy), 3.5,
        Paint()..color = _sweepColor.withOpacity(0.9));
    canvas.drawCircle(Offset(cx, cy), 7,
        Paint()
          ..color = _sweepColor.withOpacity(0.2)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4));

    final tp = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 1; i <= 4; i++) {
      tp.text = TextSpan(
        text: '${i * 25}',
        style: const TextStyle(color: Color(0xFF111154), fontSize: 8,
            fontFamily: 'Courier New'),
      );
      tp.layout();
      tp.paint(canvas, Offset(cx + 3, cy - maxR * i / 4 - 10));
    }
  }

  double _angDiff(double a, double b) {
    var d = (a - b) % (2 * pi);
    if (d < 0) d += 2 * pi;
    return d;
  }

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.sweepFraction != sweepFraction || old.blips != blips;
}

class _Blip {
  final double angle;
  final double radius;
  double birthAngle;
  final double size;
  _Blip({required this.angle, required this.radius,
      required this.birthAngle, required this.size});
}

// ─────────────────────────────────────────────────────────────────────────────
//  DATA MODEL
// ─────────────────────────────────────────────────────────────────────────────
class _HelicopterItem {
  final String letter;
  final String title;
  final String subtitle;
  final Color accentColor;
  final IconData icon;
  final String definition;

  const _HelicopterItem({
    required this.letter,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.icon,
    required this.definition,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
//  HERO VIDEO WIDGET
// ─────────────────────────────────────────────────────────────────────────────
class _HeroVideoWidget extends StatefulWidget {
  @override
  State<_HeroVideoWidget> createState() => _HeroVideoWidgetState();
}

class _HeroVideoWidgetState extends State<_HeroVideoWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/hero_video.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
          _controller.setLooping(true);
          _controller.setVolume(0); // muted — background video
          _controller.play();
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            _hasError = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        color: const Color(0xFF080838),
        child: const Center(
          child: Text(
            'Add video: assets/videos/hero_video.mp4',
            style: TextStyle(
              color: Color(0xFF4169E1),
              fontSize: 12,
              fontFamily: 'Courier New',
            ),
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return Container(
        color: const Color(0xFF080838),
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF191970),
          ),
        ),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}