import 'package:creatures_online_client/flame/components/fill_bar_component.dart';
import 'package:creatures_online_client/utils/data_image.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';

class EmptyBarComponent extends PositionComponent with HasPaint {
  EmptyBarComponent({
    required this.barPosition,
  }) : super() {
    debugMode = false;
  }

  final Vector2 barPosition;

  SpriteComponent _spriteComponent = SpriteComponent();
  final FillBarComponent _fill = FillBarComponent();

  @override
  Future<void>? onLoad() async {
    _spriteComponent = SpriteComponent()
      ..sprite = await Sprite.load(
        progressbarBg,
        images: Images(prefix: ''),
      )
      ..size = Vector2(100, 9)
      ..position = barPosition;
    await _spriteComponent.add(_fill);
    await add(_spriteComponent);
    return super.onLoad();
  }

  void changeFill(int size) {
    _fill.changeSize(size);
  }
}
