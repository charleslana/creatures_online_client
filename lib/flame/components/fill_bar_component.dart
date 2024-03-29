import 'package:creatures_online_client/data/image_data.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';

class FillBarComponent extends PositionComponent {
  SpriteComponent _spriteComponent = SpriteComponent();

  @override
  Future<void>? onLoad() async {
    _spriteComponent = SpriteComponent()
      ..sprite = await Sprite.load(
        progressbarFill,
        images: Images(prefix: ''),
      )
      ..size = Vector2(50, 9);
    await add(_spriteComponent);
    return super.onLoad();
  }

  void changeSize(int size) {
    if ((_spriteComponent.size.x + size) <= 100) {
      _spriteComponent.size.x += size;
      return;
    }
    _spriteComponent.size.x = 0;
  }
}
