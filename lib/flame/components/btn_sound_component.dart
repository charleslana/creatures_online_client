import 'package:creatures_online_client/data/image_data.dart';
import 'package:creatures_online_client/flame/btn_sound_game.dart';
import 'package:creatures_online_client/providers/sound_provider.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class BtnSoundComponent extends PositionComponent
    with HasGameRef<BtnSoundGame>, TapCallbacks {
  SpriteComponent _spriteComponent = SpriteComponent();
  late Sprite _soundOn;
  late Sprite _soundOff;

  @override
  Future<void>? onLoad() async {
    size = Vector2(40, 40);
    final sound = gameRef.ref.watch(soundProvider).value;
    _soundOn = await Sprite.load(btnSound, images: Images(prefix: ''));
    _soundOff = await Sprite.load(btnSoundOff, images: Images(prefix: ''));
    _spriteComponent = SpriteComponent()
      ..sprite = sound ? _soundOn : _soundOff
      ..size = Vector2(40, 40);
    await add(_spriteComponent);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    _toggleAudio();
    super.onTapUp(event);
  }

  Future<void> _toggleAudio() async {
    if (_spriteComponent.sprite == _soundOn) {
      _spriteComponent.sprite = _soundOff;
      gameRef.ref.read(soundProvider.notifier).changeSound(false);
      return;
    }
    _spriteComponent.sprite = _soundOn;
    gameRef.ref.read(soundProvider.notifier).changeSound(true);
  }
}
