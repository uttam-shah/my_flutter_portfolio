import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class TechSphere extends BodyComponent {
  final Vector2 initialPosition;
  final double radius;
  final String label;
  final Random _rnd = Random();
  late final TextPaint textPaint;

  TechSphere({
    required this.initialPosition,
    required this.radius,
    required this.label,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    textPaint = TextPaint(
      style: const TextStyle(
        fontSize: 1.5, // Relative to physics zoom (zoom=10 -> fontSize 15)
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius;
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.9 // Bouncy
      ..density = 0.5
      ..friction = 0.1;

    final bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.dynamic
      ..position = initialPosition
      ..linearDamping = 0.2
      ..angularDamping = 0.2;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Apply slight random impulse forces to keep them floating dynamically
    if (_rnd.nextDouble() < 0.05) {
      final impulse = (Vector2.random() - Vector2.all(0.5)) * 50 * radius;
      body.applyLinearImpulse(impulse);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Dark grey circle with a slight glow
    final paint = Paint()
      ..color = const Color(0xFF2C2C2C)
      ..style = PaintingStyle.fill;
      
    // Create an emissive/glow effect 
    final glowPaint = Paint()
       ..color = const Color(0xFF1db954).withValues(alpha: 0.3)
       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Draw glow then circle
    canvas.drawCircle(Offset.zero, radius + 1, glowPaint);
    canvas.drawCircle(Offset.zero, radius, paint);

    // Draw border
    final borderPaint = Paint()
      ..color = const Color(0xFF1db954)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2;
    canvas.drawCircle(Offset.zero, radius, borderPaint);

    // Draw text (placeholder for tech logos)
    textPaint.render(
      canvas,
      label,
      Vector2.zero(),
      anchor: Anchor.center,
    );
  }
}
