import 'package:creatures_online_client/utils/data_image.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';

class LoadingAnimatedComponent extends PositionComponent {
  SpriteAnimationComponent _spriteAnimationComponent =
      SpriteAnimationComponent();

  @override
  Future<void>? onLoad() async {
    final spriteSheet = await Images(prefix: '').load(
      loadingAnimated,
    );
    final spriteSize = Vector2(230, 230);
    SpriteAnimationData spriteAnimationData = SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.1,
      textureSize: spriteSize,
    );
    _spriteAnimationComponent =
        SpriteAnimationComponent.fromFrameData(spriteSheet, spriteAnimationData)
          ..size = spriteSize
          ..scale = Vector2(0.5, 0.5);
    await add(_spriteAnimationComponent);
    return super.onLoad();
  }
}
