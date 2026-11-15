import { module, test } from 'qunit';
import { click, render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import SiteNav, {
  SITE_NAV_ID,
} from 'blogr-landing-page-main/features/navigation-menu/ui/site-nav.gts';
import type { NavGroupId } from 'blogr-landing-page-main/entities/nav/index.ts';

const noneOpen = () => false;
const noop = () => {};

module('Integration | features | SiteNav', function (hooks) {
  setupRenderingTest(hooks);

  test('renders a labelled primary navigation', async function (assert) {
    await render(
      <template>
        <SiteNav
          @isOpen={{false}}
          @isGroupOpen={{noneOpen}}
          @onToggleGroup={{noop}}
        />
      </template>,
    );

    assert.dom(`nav#${SITE_NAV_ID}`).hasAria('label', 'Primary');
    assert.dom('nav').doesNotHaveClass('is-open');
    assert.dom('.nav-group__trigger').exists({ count: 3 });
  });

  test('renders auth links', async function (assert) {
    await render(
      <template>
        <SiteNav
          @isOpen={{false}}
          @isGroupOpen={{noneOpen}}
          @onToggleGroup={{noop}}
        />
      </template>,
    );

    assert.dom('.site-nav__login').hasText('Login').hasAttribute('href', '#');
    assert
      .dom('.site-nav__signup')
      .hasText('Sign Up')
      .hasClass('button-link--solid');
  });

  test('marks itself open and asks which group is open', async function (assert) {
    const isGroupOpen = (id: NavGroupId) => id === 'company';
    await render(
      <template>
        <SiteNav
          @isOpen={{true}}
          @isGroupOpen={{isGroupOpen}}
          @onToggleGroup={{noop}}
        />
      </template>,
    );

    assert.dom('nav').hasClass('is-open');
    assert.dom('#nav-menu-company').doesNotHaveAttribute('hidden');
    assert.dom('#nav-menu-product').hasAttribute('hidden');
    assert.dom('#nav-menu-connect').hasAttribute('hidden');
  });

  test('forwards group toggles', async function (assert) {
    const calls: NavGroupId[] = [];
    const onToggleGroup = (id: NavGroupId) => calls.push(id);
    await render(
      <template>
        <SiteNav
          @isOpen={{false}}
          @isGroupOpen={{noneOpen}}
          @onToggleGroup={{onToggleGroup}}
        />
      </template>,
    );

    await click('[aria-controls="nav-menu-product"]');
    await click('[aria-controls="nav-menu-connect"]');

    assert.deepEqual(calls, ['product', 'connect']);
  });
});
