// Based-on source: https://pub.dartlang.org/packages/animated_background
// License: MIT
import 'dart:math' as math;
import 'dart:ui';
import 'package:animated_background/particles.dart';
import 'package:flutter/material.dart';

class RainParticleBehaviour extends RandomParticleBehaviour {
  var _random = math.Random();

  RainParticleBehaviour({
    ParticleOptions options = const ParticleOptions(baseColor: Colors.blue, spawnMaxRadius: 3),
    Paint paint,
  }) : super(options: options, paint: paint);

  @override
  void initPosition(Particle p) {
    p.cx = _random.nextDouble() * size.width;
    p.cy = _random.nextDouble() * p.cy == 0.0 ? size.height : size.width * 0.2;
  }

  @override
  void initDirection(Particle p, double speed) {
    var dirX = _random.nextDouble() / 9 - 0.5 / 9;
    var dirY = _random.nextDouble() * 0.5 + 0.5;
    var magSq = dirX * dirX + dirY * dirY;
    var mag = magSq <= 0 ? 1 : math.sqrt(magSq);
    p.dx = dirX / mag * speed;
    p.dy = dirY / mag * speed;
  }

  @override
  Widget builder(BuildContext bc, BoxConstraints constraints, Widget child) {
    return GestureDetector(
      onPanUpdate: (details) => _updateParticles(bc, details.globalPosition),
      onTapDown: (details) => _updateParticles(bc, details.globalPosition),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: double.infinity, minWidth: double.infinity),
        child: super.builder(bc, constraints, child),
      ),
    );
  }

  void _updateParticles(BuildContext bc, Offset offsetGlobal) {
    RenderBox renderBox = bc.findRenderObject() as RenderBox;
    var offset = renderBox.globalToLocal(offsetGlobal);
    particles.forEach((particle) {
      var delta = Offset(particle.cx, particle.cy) - offset;
      if (delta.distanceSquared < 70 * 70) {
        var speed = particle.speed;
        var mag = delta.distance;
        speed *= (70 - mag) / 70.0 * 2.0 + 0.5;
        speed = math.max(options.spawnMinSpeed, math.min(options.spawnMaxSpeed, speed));
        particle.dx = delta.dx / mag * speed;
        particle.dy = delta.dy / mag * speed;
      }
    });
  }

}