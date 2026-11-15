import { module, test } from 'qunit';
import { assetUrl } from 'blogr-landing-page-main/shared/config/assets.ts';

module('Unit | shared | assetUrl', function () {
  test('joins a root base with a relative path', function (assert) {
    assert.strictEqual(assetUrl('images/logo.svg', '/'), '/images/logo.svg');
  });

  test('keeps a sub-path base intact', function (assert) {
    assert.strictEqual(
      assetUrl('images/logo.svg', '/BlogrLandingPage/'),
      '/BlogrLandingPage/images/logo.svg',
    );
  });

  test('adds a missing trailing slash to the base', function (assert) {
    assert.strictEqual(
      assetUrl('images/logo.svg', '/BlogrLandingPage'),
      '/BlogrLandingPage/images/logo.svg',
    );
  });

  test('strips leading "/" and "./" from the path', function (assert) {
    assert.strictEqual(assetUrl('/images/a.svg', '/x/'), '/x/images/a.svg');
    assert.strictEqual(assetUrl('./images/a.svg', '/x/'), '/x/images/a.svg');
  });

  test('defaults to the Vite BASE_URL', function (assert) {
    assert.strictEqual(
      assetUrl('images/logo.svg'),
      `${import.meta.env.BASE_URL}images/logo.svg`,
    );
  });
});
