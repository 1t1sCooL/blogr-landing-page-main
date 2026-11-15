import { module, test } from 'qunit';
import { click, currentURL, triggerKeyEvent, visit } from '@ember/test-helpers';
import { setupApplicationTest } from 'blogr-landing-page-main/tests/helpers/index.ts';

const trigger = (id: string) => `.site-header [aria-controls="nav-menu-${id}"]`;
const menu = (id: string) => `#nav-menu-${id}`;

module('Acceptance | landing page', function (hooks) {
  setupApplicationTest(hooks);

  test('visiting / renders the whole landing', async function (assert) {
    await visit('/');

    assert.strictEqual(currentURL(), '/');
    assert.dom('h1').hasText('A modern publishing platform');
    assert.dom('main section').exists({ count: 4 });
    assert.dom('footer.site-footer').exists();
  });

  test('desktop navigation flow: open, switch, dismiss', async function (assert) {
    await visit('/');

    await click(trigger('product'));
    assert.dom(menu('product')).doesNotHaveAttribute('hidden');
    assert.dom(trigger('product')).hasAria('expanded', 'true');

    await click(trigger('connect'));
    assert.dom(menu('product')).hasAttribute('hidden');
    assert.dom(menu('connect')).doesNotHaveAttribute('hidden');

    await click('h1');
    assert.dom(menu('connect')).hasAttribute('hidden');

    await click(trigger('company'));
    await triggerKeyEvent(trigger('company'), 'keydown', 'Escape');
    assert.dom(menu('company')).hasAttribute('hidden');
    assert.dom(trigger('company')).isFocused();
  });

  test('mobile navigation flow: open menu, expand group, close', async function (assert) {
    await visit('/');

    await click('.menu-toggle');
    assert.dom('.site-nav').hasClass('is-open');
    assert.dom('.menu-toggle').hasAria('label', 'Close menu');

    await click(trigger('connect'));
    assert.dom(menu('connect')).doesNotHaveAttribute('hidden');

    await click('.menu-toggle');
    assert.dom('.site-nav').doesNotHaveClass('is-open');
    assert.dom(menu('connect')).hasAttribute('hidden');
    assert.dom('.menu-toggle').hasAria('label', 'Open menu');
  });

  test('footer navigation does not toggle the header menus', async function (assert) {
    await visit('/');

    await click('.site-footer__link');

    assert.dom('.nav-group__trigger[aria-expanded="true"]').doesNotExist();
    assert.dom('.site-nav').doesNotHaveClass('is-open');
  });
});
