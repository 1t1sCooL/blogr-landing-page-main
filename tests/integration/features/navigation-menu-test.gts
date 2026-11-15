import { module, test } from 'qunit';
import { click, focus, render, triggerKeyEvent } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import { NavigationMenu } from 'blogr-landing-page-main/features/navigation-menu/index.ts';

const trigger = (id: string) => `[aria-controls="nav-menu-${id}"]`;
const menu = (id: string) => `#nav-menu-${id}`;

module('Integration | features | NavigationMenu', function (hooks) {
  setupRenderingTest(hooks);

  hooks.beforeEach(async function () {
    await render(
      <template>
        <NavigationMenu />
        <button type="button" data-test-outside>outside</button>
      </template>,
    );
  });

  test('starts fully collapsed', function (assert) {
    assert.dom('.menu-toggle').hasAria('expanded', 'false');
    assert.dom('.site-nav').doesNotHaveClass('is-open');
    assert.dom('.nav-group__trigger[aria-expanded="true"]').doesNotExist();
  });

  test('opens one dropdown at a time', async function (assert) {
    await click(trigger('product'));
    assert.dom(menu('product')).doesNotHaveAttribute('hidden');

    await click(trigger('company'));
    assert.dom(menu('product')).hasAttribute('hidden');
    assert.dom(menu('company')).doesNotHaveAttribute('hidden');

    await click(trigger('company'));
    assert.dom(menu('company')).hasAttribute('hidden');
  });

  test('closes on outside click but not on inside click', async function (assert) {
    await click(trigger('connect'));
    await click(`${menu('connect')} a`);
    assert
      .dom(menu('connect'))
      .doesNotHaveAttribute('hidden', 'inside click keeps it open');

    await click('[data-test-outside]');
    assert.dom(menu('connect')).hasAttribute('hidden');
  });

  test('Escape closes the dropdown and returns focus to its trigger', async function (assert) {
    await click(trigger('product'));
    await focus(`${menu('product')} a`);

    await triggerKeyEvent(`${menu('product')} a`, 'keydown', 'Escape');

    assert.dom(menu('product')).hasAttribute('hidden');
    assert.dom(trigger('product')).isFocused();
  });

  test('mobile toggle opens and closes the whole menu', async function (assert) {
    await click('.menu-toggle');
    assert
      .dom('.menu-toggle')
      .hasAria('expanded', 'true')
      .hasAria('label', 'Close menu');
    assert.dom('.site-nav').hasClass('is-open');

    await click(trigger('connect'));
    assert.dom(menu('connect')).doesNotHaveAttribute('hidden');

    await click('.menu-toggle');
    assert.dom('.site-nav').doesNotHaveClass('is-open');
    assert.dom(menu('connect')).hasAttribute('hidden');
  });

  test('clicking the toggle icon keeps the mobile menu open', async function (assert) {
    await click('.menu-toggle svg');

    assert.dom('.site-nav').hasClass('is-open');
    assert.dom('.icon-close').exists();
  });

  test('Escape closes the mobile menu and focuses the toggle', async function (assert) {
    // The test runner viewport is desktop-sized, where the toggle is display:none
    // and therefore not focusable.
    const forceVisible = document.createElement('style');
    forceVisible.textContent = '.menu-toggle { display: block !important; }';
    document.head.append(forceVisible);

    try {
      await click('.menu-toggle');

      await triggerKeyEvent('.menu-toggle', 'keydown', 'Escape');

      assert.dom('.site-nav').doesNotHaveClass('is-open');
      assert.dom('.menu-toggle').isFocused();
    } finally {
      forceVisible.remove();
    }
  });

  test('outside click closes the mobile menu', async function (assert) {
    await click('.menu-toggle');
    await click('[data-test-outside]');

    assert.dom('.site-nav').doesNotHaveClass('is-open');
  });
});
