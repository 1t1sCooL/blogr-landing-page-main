import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import {
  FeatureArticle,
  type Feature,
} from 'blogr-landing-page-main/entities/feature/index.ts';

const feature: Feature = { id: 'demo', title: 'Demo title', text: 'Demo text' };

module('Integration | entities | FeatureArticle', function (hooks) {
  setupRenderingTest(hooks);

  test('renders an article labelled by its heading', async function (assert) {
    await render(<template><FeatureArticle @feature={{feature}} /></template>);

    assert.dom('article').hasAria('labelledby', 'feature-demo-title');
    assert.dom('article h3#feature-demo-title').hasText('Demo title');
    assert.dom('article p').hasText('Demo text');
  });

  test('defaults to the light regular look', async function (assert) {
    await render(<template><FeatureArticle @feature={{feature}} /></template>);

    assert
      .dom('article')
      .hasClass('feature-article--light')
      .hasClass('feature-article--regular');
  });

  test('supports the dark large look', async function (assert) {
    await render(
      <template>
        <FeatureArticle @feature={{feature}} @tone="dark" @size="large" />
      </template>,
    );

    assert
      .dom('article')
      .hasClass('feature-article--dark')
      .hasClass('feature-article--large');
  });
});
