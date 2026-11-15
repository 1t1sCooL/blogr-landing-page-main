import { module, test } from 'qunit';
import { click, render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import MenuToggle from 'blogr-landing-page-main/features/navigation-menu/ui/menu-toggle.gts';

module('Integration | features | MenuToggle', function (hooks) {
  setupRenderingTest(hooks);

  test('shows the hamburger while closed', async function (assert) {
    const noop = () => {};
    await render(
      <template>
        <MenuToggle @isOpen={{false}} @controls="nav" @onToggle={{noop}} />
      </template>,
    );

    assert
      .dom('button.menu-toggle')
      .hasAttribute('type', 'button')
      .hasAria('expanded', 'false')
      .hasAria('controls', 'nav')
      .hasAria('label', 'Open menu');
    assert.dom('.icon-hamburger').exists();
    assert.dom('.icon-close').doesNotExist();
  });

  test('shows the close icon while open', async function (assert) {
    const noop = () => {};
    await render(
      <template>
        <MenuToggle @isOpen={{true}} @controls="nav" @onToggle={{noop}} />
      </template>,
    );

    assert
      .dom('button')
      .hasAria('expanded', 'true')
      .hasAria('label', 'Close menu');
    assert.dom('.icon-close').exists();
    assert.dom('.icon-hamburger').doesNotExist();
  });

  test('calls onToggle on click', async function (assert) {
    let count = 0;
    const onToggle = () => count++;
    await render(
      <template>
        <MenuToggle @isOpen={{false}} @controls="nav" @onToggle={{onToggle}} />
      </template>,
    );

    await click('button');

    assert.strictEqual(count, 1);
  });
});
