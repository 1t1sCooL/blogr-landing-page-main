import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import { SiteHeader } from 'blogr-landing-page-main/widgets/site-header/index.ts';

module('Integration | widgets | SiteHeader', function (hooks) {
  setupRenderingTest(hooks);

  test('renders the home logo and the navigation menu', async function (assert) {
    await render(<template><SiteHeader /></template>);

    assert.dom('header.site-header').exists();
    assert
      .dom('header .site-header__home img.logo')
      .hasAttribute('alt', 'Blogr');
    assert.dom('header .menu-toggle').exists();
    assert.dom('header nav.site-nav').exists();
  });
});
