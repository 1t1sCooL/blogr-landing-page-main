import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import { Intro } from 'blogr-landing-page-main/widgets/intro/index.ts';

module('Integration | widgets | Intro', function (hooks) {
  setupRenderingTest(hooks);

  test('renders the hero section labelled by the page heading', async function (assert) {
    await render(<template><Intro /></template>);

    assert.dom('section.intro').hasAria('labelledby', 'intro-title');
    assert.dom('h1#intro-title').hasText('A modern publishing platform');
    assert
      .dom('.intro__lead')
      .hasText('Grow your audience and build your online brand');
  });

  test('renders both calls to action', async function (assert) {
    await render(<template><Intro /></template>);

    assert.dom('.intro__actions a').exists({ count: 2 });
    assert
      .dom('.intro__actions a:nth-child(1)')
      .hasText('Start for Free')
      .hasClass('button-link--solid');
    assert
      .dom('.intro__actions a:nth-child(2)')
      .hasText('Learn More')
      .hasClass('button-link--outline');
  });
});
