import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import { DesignedForFuture } from 'blogr-landing-page-main/widgets/designed-for-future/index.ts';
import { InfrastructureSection } from 'blogr-landing-page-main/widgets/infrastructure/index.ts';
import { ToolingSection } from 'blogr-landing-page-main/widgets/tooling/index.ts';

const base = import.meta.env.BASE_URL;

module('Integration | widgets | content sections', function (hooks) {
  setupRenderingTest(hooks);

  test('DesignedForFuture: heading, art-directed editor and two features', async function (assert) {
    await render(<template><DesignedForFuture /></template>);

    assert.dom('section.designed').hasAria('labelledby', 'designed-title');
    assert.dom('h2#designed-title').hasText('Designed for the future');
    assert
      .dom('.designed__illustration')
      .hasAttribute('src', `${base}images/illustration-editor-desktop.svg`)
      .hasAttribute('alt', '');
    assert
      .dom('.designed picture source')
      .hasAttribute('srcset', `${base}images/illustration-editor-mobile.svg`);
    assert.dom('.designed__features article').exists({ count: 2 });
    assert
      .dom('.designed__features .feature-article--light')
      .exists({ count: 2 });
  });

  test('InfrastructureSection: dark large feature labelled by its title', async function (assert) {
    await render(<template><InfrastructureSection /></template>);

    assert
      .dom('section.infrastructure')
      .hasAria('labelledby', 'feature-infrastructure-title');
    assert
      .dom('#feature-infrastructure-title')
      .hasText('State of the Art Infrastructure');
    assert
      .dom('.infrastructure__illustration')
      .hasAttribute('src', `${base}images/illustration-phones.svg`);
    assert.dom('.infrastructure picture source').doesNotExist();
    assert
      .dom('.infrastructure__features article')
      .hasClass('feature-article--dark')
      .hasClass('feature-article--large');
  });

  test('ToolingSection: art-directed laptop and two features', async function (assert) {
    await render(<template><ToolingSection /></template>);

    assert.dom('section.tooling').hasAria('label', 'Open source tooling');
    assert
      .dom('.tooling__illustration')
      .hasAttribute('src', `${base}images/illustration-laptop-desktop.svg`);
    assert
      .dom('.tooling picture source')
      .hasAttribute('srcset', `${base}images/illustration-laptop-mobile.svg`);
    assert.dom('.tooling__features h3').exists({ count: 2 });
    assert
      .dom('.tooling__features article:nth-child(1) h3')
      .hasText('Free, open, simple');
    assert
      .dom('.tooling__features article:nth-child(2) h3')
      .hasText('Powerful tooling');
  });
});
