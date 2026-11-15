import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import IconChevron from 'blogr-landing-page-main/shared/ui/icons/icon-chevron.gts';
import IconHamburger from 'blogr-landing-page-main/shared/ui/icons/icon-hamburger.gts';
import IconClose from 'blogr-landing-page-main/shared/ui/icons/icon-close.gts';

module('Integration | shared | icons', function (hooks) {
  setupRenderingTest(hooks);

  test('icons are decorative and inherit text colour', async function (assert) {
    await render(
      <template>
        <IconChevron data-test-icon="chevron" />
        <IconHamburger data-test-icon="hamburger" />
        <IconClose data-test-icon="close" />
      </template>,
    );

    for (const name of ['chevron', 'hamburger', 'close']) {
      const selector = `svg[data-test-icon="${name}"]`;
      assert.dom(selector).hasAttribute('aria-hidden', 'true');
      assert.dom(selector).hasAttribute('focusable', 'false');
      assert.dom(selector).hasClass(`icon-${name}`);
      assert
        .dom(
          `${selector} [stroke="currentColor"], ${selector} [fill="currentColor"]`,
        )
        .exists(`${name} paints with currentColor`);
    }
  });

  test('icons forward attributes', async function (assert) {
    await render(<template><IconChevron class="custom" /></template>);

    assert.dom('svg').hasClass('icon-chevron').hasClass('custom');
  });
});
