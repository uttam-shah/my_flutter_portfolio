import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'sphere_body.dart';
import 'pointer_body.dart';

// Invisible wall boundaries
class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;

  Wall(this.start, this.end);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape)..friction = 0.0..restitution = 1.0;
    final bodyDef = BodyDef()
      ..userData = this
      ..position = Vector2.zero()
      ..type = BodyType.static;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class TechStackGame extends Forge2DGame with MouseMovementDetector, PanDetector {
  TechStackGame() : super(gravity: Vector2.zero(), zoom: 10);

  late PointerCursor _pointer;
  final Random _rnd = Random();

  final List<String> techLogos = [
    'React', 'Next.js', 'Node.js', 'Express',
    'MongoDB', 'MySQL', 'TypeScript', 'JavaScript',
    'Flutter', 'Firebase', 'Dart', 'AWS'
  ];

  final List<Wall> _walls = [];

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Spawn the pointer cursor
    _pointer = PointerCursor();
    await add(_pointer);

    // Spawn 25-30 floating spheres
    final numSpheres = 25 + _rnd.nextInt(6);
    
    for (int i = 0; i < numSpheres; i++) {
      // Random position roughly around middle initially
      final initialX = _rnd.nextDouble() * 50 - 25; 
      final initialY = _rnd.nextDouble() * 50 - 25;
      
      // Random scale (0.7 to 1.0 base radius mapping)
      final radius = 3.5 + _rnd.nextDouble() * 1.5; 
      
      final label = techLogos[_rnd.nextInt(techLogos.length)];

      await add(TechSphere(
        initialPosition: Vector2(initialX, initialY),
        radius: radius,
        label: label,
      ));
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _buildBoundaries();
  }

  void _buildBoundaries() {
    // Clear old walls
    for (final wall in _walls) {
      if (wall.isMounted) remove(wall);
    }
    _walls.clear();

    final rect = camera.visibleWorldRect;
    
    // Create new walls forming a box around visible rect
    final topLeft = Vector2(rect.left, rect.top);
    final topRight = Vector2(rect.right, rect.top);
    final bottomLeft = Vector2(rect.left, rect.bottom);
    final bottomRight = Vector2(rect.right, rect.bottom);

    final w1 = Wall(topLeft, topRight);
    final w2 = Wall(topRight, bottomRight);
    final w3 = Wall(bottomRight, bottomLeft);
    final w4 = Wall(bottomLeft, topLeft);
    
    _walls.addAll([w1, w2, w3, w4]);
    addAll(_walls);
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    super.onMouseMove(info);
    _pointer.targetPosition = screenToWorld(info.eventPosition.widget);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);
    _pointer.targetPosition = screenToWorld(info.eventPosition.widget);
  }
}
