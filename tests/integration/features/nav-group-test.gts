import { module, test } from 'qunit';
import { click, render, settled } from '@ember/test-helpers';
import { tracked } from '@glimmer/tracking';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import NavGroupItem from 'blogr-landing-page-main/features/navigation-menu/ui/nav-group.gts';
import {
  findNavGroup,
  type NavGroup,
  type NavGroupId,
} from 'blogr-landing-page-main/entities/nav/index.ts';

const group = findNavGroup('connect') as NavGroup;

class Open {
  @tracked value = false;
}

module('Integration | features | NavGroupItem', function (hooks) {
  setupRenderingTest(hooks);

  test('renders a collapsed disclosure', async function (assert) {
    const noop = () => {};
    await render(
      <template>
        <ul><NavGroupItem
            @group={{group}}
            @isOpen={{false}}
            @onToggle={{noop}}
          /></ul>
      </template>,
    );

    assert
      .dom('.nav-group__trigger')
      .hasText('Connect')
      .hasAttribute('type', 'button')
      .hasAria('expanded', 'false')
      .hasAria('controls', 'nav-menu-connect');
    assert.dom('.nav-group__chevron').exists();
    assert.dom('#nav-menu-connect').hasAttribute('hidden');
    assert.dom('.nav-group').doesNotHaveClass('is-open');
  });

  test('lists every link of the group', async function (assert) {
    const noop = () => {};
    await render(
      <template>
        <ul><NavGroupItem
            @group={{group}}
            @isOpen={{true}}
            @onToggle={{noop}}
          /></ul>
      </template>,
    );

    assert.dom('.nav-group__link').exists({ count: 3 });
    assert.deepEqual(
      [...document.querySelectorAll('.nav-group__link')].map(
        (link) => link.textContent,
      ),
      ['Contact', 'Newsletter', 'LinkedIn'],
    );
  });

  test('reflects the open state', async function (assert) {
    const open = new Open();
    const noop = () => {};
    await render(
      <template>
        <ul><NavGroupItem
            @group={{group}}
            @isOpen={{open.value}}
            @onToggle={{noop}}
          /></ul>
      </template>,
    );

    open.value = true;
    await settled();

    assert.dom('.nav-group').hasClass('is-open');
    assert.dom('.nav-group__trigger').hasAria('expanded', 'true');
    assert.dom('#nav-menu-connect').doesNotHaveAttribute('hidden');
  });

  test('calls onToggle with the group id', async function (assert) {
    const calls: NavGroupId[] = [];
    const onToggle = (id: NavGroupId) => calls.push(id);
    await render(
      <template>
        <ul><NavGroupItem
            @group={{group}}
            @isOpen={{false}}
            @onToggle={{onToggle}}
          /></ul>
      </template>,
    );

    await click('.nav-group__trigger');

    assert.deepEqual(calls, ['connect']);
  });
});
