import { module, test } from 'qunit';
import {
  MenuState,
  menuToggleLabel,
  toggleId,
} from 'blogr-landing-page-main/features/navigation-menu/index.ts';

module('Unit | features | menu state', function () {
  test('toggleId opens, switches and closes', function (assert) {
    assert.strictEqual(toggleId(null, 'a'), 'a');
    assert.strictEqual(toggleId('a', 'b'), 'b');
    assert.strictEqual(toggleId('a', 'a'), null);
  });

  test('menuToggleLabel reflects the next action', function (assert) {
    assert.strictEqual(menuToggleLabel(false), 'Open menu');
    assert.strictEqual(menuToggleLabel(true), 'Close menu');
  });

  test('starts closed', function (assert) {
    const state = new MenuState();
    assert.strictEqual(state.openGroupId, null);
    assert.false(state.isMobileOpen);
    assert.false(state.isAnyOpen);
  });

  test('toggleGroup keeps a single group open', function (assert) {
    const state = new MenuState();

    state.toggleGroup('product');
    assert.true(state.isGroupOpen('product'));
    assert.true(state.isAnyOpen);

    state.toggleGroup('connect');
    assert.false(state.isGroupOpen('product'));
    assert.true(state.isGroupOpen('connect'));

    state.toggleGroup('connect');
    assert.strictEqual(state.openGroupId, null);
    assert.false(state.isAnyOpen);
  });

  test('closing the mobile menu also collapses its group', function (assert) {
    const state = new MenuState();

    state.toggleMobile();
    state.toggleGroup('company');
    assert.true(state.isMobileOpen);
    assert.true(state.isGroupOpen('company'));

    state.toggleMobile();
    assert.false(state.isMobileOpen);
    assert.strictEqual(state.openGroupId, null);
  });

  test('closeAll resets everything', function (assert) {
    const state = new MenuState();
    state.toggleMobile();
    state.toggleGroup('product');

    state.closeAll();

    assert.false(state.isMobileOpen);
    assert.strictEqual(state.openGroupId, null);
    assert.false(state.isAnyOpen);
  });

  test('bound methods survive being passed around', function (assert) {
    const state = new MenuState();
    const { toggleGroup, toggleMobile, isGroupOpen } = state;

    toggleMobile();
    toggleGroup('connect');

    assert.true(state.isMobileOpen);
    assert.true(isGroupOpen('connect'));
  });
});
