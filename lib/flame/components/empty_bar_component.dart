import 'package:creatures_online_client/flame/components/fill_bar_component.dart';
import 'package:creatures_online_client/utils/data_image.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';

class EmptyBarComponent extends PositionComponent {
  SpriteComponent _spriteComponent = SpriteComponent();
  final FillBarComponent _fill = FillBarComponent();

  @override
  Future<void>? onLoad() async {
    _spriteComponent = SpriteComponent()
      ..sprite = await Sprite.load(
        progressbarBg,
        images: Images(prefix: ''),
      )
      ..size = Vector2(100, 9);
    await _spriteComponent.add(_fill);
    await add(_spriteComponent);
    return super.onLoad();
  }

  void changeFill(int size) {
    _fill.changeSize(size);
  }
}
