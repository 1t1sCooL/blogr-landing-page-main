import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import Logo from 'blogr-landing-page-main/shared/ui/logo/logo.gts';

module('Integration | shared | Logo', function (hooks) {
  setupRenderingTest(hooks);

  test('renders the brand image with intrinsic size', async function (assert) {
    await render(<template><Logo /></template>);

    assert
      .dom('img.logo')
      .hasAttribute('alt', 'Blogr')
      .hasAttribute('width', '101')
      .hasAttribute('height', '40')
      .hasAttribute('src', `${import.meta.env.BASE_URL}images/logo.svg`);
  });

  test('forwards attributes', async function (assert) {
    await render(<template><Logo class="extra" data-test-logo /></template>);

    assert.dom('[data-test-logo]').hasClass('logo').hasClass('extra');
  });
});
