import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import ArtDirectedImage, {
  type ImageAsset,
} from 'blogr-landing-page-main/shared/ui/art-directed-image/art-directed-image.gts';
import { MOBILE_MEDIA } from 'blogr-landing-page-main/shared/config/media.ts';

const desktop: ImageAsset = { src: '/d.svg', width: 900, height: 800 };
const mobile: ImageAsset = { src: '/m.svg', width: 400, height: 300 };

module('Integration | shared | ArtDirectedImage', function (hooks) {
  setupRenderingTest(hooks);

  test('renders a lazy decorative image without a mobile source', async function (assert) {
    await render(
      <template><ArtDirectedImage @desktop={{desktop}} /></template>,
    );

    assert.dom('picture source').doesNotExist();
    assert
      .dom('picture img')
      .hasAttribute('src', '/d.svg')
      .hasAttribute('width', '900')
      .hasAttribute('height', '800')
      .hasAttribute('alt', '')
      .hasAttribute('loading', 'lazy')
      .hasAttribute('decoding', 'async');
  });

  test('adds an art-directed source for mobile', async function (assert) {
    await render(
      <template>
        <ArtDirectedImage @desktop={{desktop}} @mobile={{mobile}} />
      </template>,
    );

    assert
      .dom('picture source')
      .hasAttribute('media', MOBILE_MEDIA)
      .hasAttribute('srcset', '/m.svg')
      .hasAttribute('width', '400')
      .hasAttribute('height', '300');
  });

  test('supports alt text and forwards attributes to the img', async function (assert) {
    await render(
      <template>
        <ArtDirectedImage @desktop={{desktop}} @alt="Editor" class="hero" />
      </template>,
    );

    assert.dom('img').hasAttribute('alt', 'Editor').hasClass('hero');
  });
});
