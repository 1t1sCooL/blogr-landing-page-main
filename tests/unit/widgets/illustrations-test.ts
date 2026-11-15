import { module, test } from 'qunit';
import { EDITOR_ILLUSTRATION } from 'blogr-landing-page-main/widgets/designed-for-future/model/illustration.ts';
import { PHONES_ILLUSTRATION } from 'blogr-landing-page-main/widgets/infrastructure/model/illustration.ts';
import { LAPTOP_ILLUSTRATION } from 'blogr-landing-page-main/widgets/tooling/model/illustration.ts';
import type { ImageAsset } from 'blogr-landing-page-main/shared/ui/art-directed-image/art-directed-image.gts';

const base = import.meta.env.BASE_URL;

const assertAsset = (
  assert: Assert,
  asset: ImageAsset,
  file: string,
  width: number,
  height: number,
) => {
  assert.strictEqual(asset.src, `${base}images/${file}`);
  assert.strictEqual(asset.width, width);
  assert.strictEqual(asset.height, height);
};

module('Unit | widgets | illustrations', function () {
  test('editor illustration uses intrinsic sizes for both breakpoints', function (assert) {
    assertAsset(
      assert,
      EDITOR_ILLUSTRATION.desktop,
      'illustration-editor-desktop.svg',
      925,
      882,
    );
    assertAsset(
      assert,
      EDITOR_ILLUSTRATION.mobile,
      'illustration-editor-mobile.svg',
      406,
      331,
    );
  });

  test('phones illustration', function (assert) {
    assertAsset(
      assert,
      PHONES_ILLUSTRATION,
      'illustration-phones.svg',
      552,
      579,
    );
  });

  test('laptop illustration uses intrinsic sizes for both breakpoints', function (assert) {
    assertAsset(
      assert,
      LAPTOP_ILLUSTRATION.desktop,
      'illustration-laptop-desktop.svg',
      974,
      786,
    );
    assertAsset(
      assert,
      LAPTOP_ILLUSTRATION.mobile,
      'illustration-laptop-mobile.svg',
      498,
      359,
    );
  });
});
