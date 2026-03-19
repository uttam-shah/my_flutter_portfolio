import 'package:flame_forge2d/flame_forge2d.dart';

class PointerCursor extends BodyComponent {
  Vector2 targetPosition = Vector2.zero();
  
  @override
  Body createBody() {
    final shape = CircleShape()..radius = 4.0;
    // Heavy density and high restitution so it repels balls forcefully
    final fixtureDef = FixtureDef(shape)
      ..restitution = 1.0
      ..density = 50.0 
      ..friction = 0.1;
      
    final bodyDef = BodyDef()
      ..type = BodyType.kinematic
      ..position = targetPosition;
      
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    // Smoothly seek the pointer
    if (body.isActive) {
      final currentPos = body.position;
      final direction = targetPosition - currentPos;
      body.linearVelocity = direction * 15.0; // Seek speed multiplexer
    }
  }
}
