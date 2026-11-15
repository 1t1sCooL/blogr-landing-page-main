import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import ButtonLink from 'blogr-landing-page-main/shared/ui/button-link/button-link.gts';

module('Integration | shared | ButtonLink', function (hooks) {
  setupRenderingTest(hooks);

  test('renders a solid link by default', async function (assert) {
    await render(
      <template>
        <ButtonLink @href="/start">Start</ButtonLink>
      </template>,
    );

    assert
      .dom('a')
      .hasClass('button-link')
      .hasClass('button-link--solid')
      .hasAttribute('href', '/start')
      .hasText('Start');
  });

  test('applies the requested variant', async function (assert) {
    await render(
      <template>
        <ButtonLink
          @href="#"
          @variant="outline"
          data-test-outline
        >A</ButtonLink>
        <ButtonLink
          @href="#"
          @variant="gradient"
          data-test-gradient
        >B</ButtonLink>
      </template>,
    );

    assert.dom('[data-test-outline]').hasClass('button-link--outline');
    assert.dom('[data-test-outline]').doesNotHaveClass('button-link--solid');
    assert.dom('[data-test-gradient]').hasClass('button-link--gradient');
  });

  test('caller attributes override and extend', async function (assert) {
    await render(
      <template>
        <ButtonLink @href="#" class="extra" aria-label="Custom">Go</ButtonLink>
      </template>,
    );

    assert
      .dom('a')
      .hasClass('button-link')
      .hasClass('extra')
      .hasAria('label', 'Custom');
  });
});
