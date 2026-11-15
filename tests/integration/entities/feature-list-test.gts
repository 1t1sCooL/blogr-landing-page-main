import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import {
  FeatureList,
  type Feature,
} from 'blogr-landing-page-main/entities/feature/index.ts';

const features: Feature[] = [
  { id: 'one', title: 'One', text: 'First' },
  { id: 'two', title: 'Two', text: 'Second' },
];

module('Integration | entities | FeatureList', function (hooks) {
  setupRenderingTest(hooks);

  test('renders an article per feature in order', async function (assert) {
    await render(<template><FeatureList @features={{features}} /></template>);

    assert.dom('.feature-list article').exists({ count: 2 });
    assert.dom('.feature-list article:nth-child(1) h3').hasText('One');
    assert.dom('.feature-list article:nth-child(2) h3').hasText('Two');
  });

  test('passes tone and size down to every article', async function (assert) {
    await render(
      <template>
        <FeatureList @features={{features}} @tone="dark" @size="large" />
      </template>,
    );

    assert
      .dom('.feature-article--dark.feature-article--large')
      .exists({ count: 2 });
  });

  test('forwards attributes to the wrapper', async function (assert) {
    await render(
      <template>
        <FeatureList @features={{features}} class="custom" />
      </template>,
    );

    assert.dom('.feature-list').hasClass('custom');
  });
});
