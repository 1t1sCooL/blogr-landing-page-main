import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import { SiteFooter } from 'blogr-landing-page-main/widgets/site-footer/index.ts';
import { NAV_GROUPS } from 'blogr-landing-page-main/entities/nav/index.ts';

module('Integration | widgets | SiteFooter', function (hooks) {
  setupRenderingTest(hooks);

  test('renders the logo and a labelled nav per group', async function (assert) {
    await render(<template><SiteFooter /></template>);

    assert.dom('footer .site-footer__home img.logo').exists();
    assert
      .dom('footer nav.site-footer__group')
      .exists({ count: NAV_GROUPS.length });

    for (const group of NAV_GROUPS) {
      const headingId = `footer-${group.id}-title`;
      assert.dom(`nav[aria-labelledby="${headingId}"]`).exists();
      assert.dom(`h2#${headingId}`).hasText(group.label);
      assert
        .dom(`nav[aria-labelledby="${headingId}"] .site-footer__link`)
        .exists({ count: group.links.length });
    }
  });

  test('credits Frontend Mentor and the author in a new tab', async function (assert) {
    await render(<template><SiteFooter /></template>);

    assert
      .dom('.site-footer__attribution a[href^="https://www.frontendmentor.io"]')
      .hasText('Frontend Mentor')
      .hasAttribute('target', '_blank')
      .hasAttribute('rel', 'noopener noreferrer');
    assert
      .dom('.site-footer__attribution a[href="https://mmalabugin.ru"]')
      .hasText('1t1sCooL')
      .hasAttribute('rel', 'noopener noreferrer');
  });
});
