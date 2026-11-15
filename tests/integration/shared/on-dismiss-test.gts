import { module, test } from 'qunit';
import { click, render, settled, triggerKeyEvent } from '@ember/test-helpers';
import { tracked } from '@glimmer/tracking';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import {
  onDismiss,
  type DismissReason,
} from 'blogr-landing-page-main/shared/lib/dismiss/on-dismiss.ts';

class Toggle {
  @tracked enabled = true;
}

const createRecorder = () => {
  const calls: DismissReason[] = [];
  const handler = (reason: DismissReason) => calls.push(reason);
  return { calls, handler };
};

module('Integration | shared | onDismiss modifier', function (hooks) {
  setupRenderingTest(hooks);

  test('reports outside clicks and ignores inside clicks', async function (assert) {
    const { calls, handler } = createRecorder();

    await render(
      <template>
        <div data-test-root {{onDismiss handler}}><button
            type="button"
            data-test-inside
          >in</button></div>
        <button type="button" data-test-outside>out</button>
      </template>,
    );

    await click('[data-test-inside]');
    assert.deepEqual(calls, []);

    await click('[data-test-outside]');
    assert.deepEqual(calls, ['outside']);
  });

  test('reports Escape from anywhere', async function (assert) {
    const { calls, handler } = createRecorder();

    await render(
      <template>
        <div {{onDismiss handler}}><button
            type="button"
            data-test-inside
          >in</button></div>
      </template>,
    );

    await triggerKeyEvent('[data-test-inside]', 'keydown', 'Enter');
    await triggerKeyEvent('[data-test-inside]', 'keydown', 'Escape');
    assert.deepEqual(calls, ['escape']);
  });

  test('passes the host element to the handler', async function (assert) {
    let received: HTMLElement | undefined;
    const handler = (_reason: DismissReason, element: HTMLElement) => {
      received = element;
    };

    await render(
      <template>
        <div data-test-root {{onDismiss handler}}></div>
        <button type="button" data-test-outside>out</button>
      </template>,
    );
    await click('[data-test-outside]');

    assert.strictEqual(received, document.querySelector('[data-test-root]'));
  });

  test('does not listen while disabled and re-subscribes when enabled', async function (assert) {
    const { calls, handler } = createRecorder();
    const toggle = new Toggle();
    toggle.enabled = false;

    await render(
      <template>
        <div {{onDismiss handler enabled=toggle.enabled}}></div>
        <button type="button" data-test-outside>out</button>
      </template>,
    );

    await click('[data-test-outside]');
    assert.deepEqual(calls, [], 'disabled');

    toggle.enabled = true;
    await settled();
    await click('[data-test-outside]');
    assert.deepEqual(calls, ['outside'], 'enabled');
  });

  test('removes listeners on teardown', async function (assert) {
    const { calls, handler } = createRecorder();
    const toggle = new Toggle();

    await render(
      <template>
        {{#if toggle.enabled}}
          <div {{onDismiss handler}}></div>
        {{/if}}
        <button type="button" data-test-outside>out</button>
      </template>,
    );

    toggle.enabled = false;
    await settled();
    await click('[data-test-outside]');
    assert.deepEqual(calls, []);
  });

  test('an inside target removed mid-dispatch is still treated as inside', async function (assert) {
    const { calls, handler } = createRecorder();
    const detachTarget = (event: Event) => (event.target as Element).remove();

    await render(
      <template>
        <div {{onDismiss handler}}>
          <button type="button" data-test-inside>
            <span data-test-icon>icon</span>
          </button>
        </div>
      </template>,
    );
    document
      .querySelector('[data-test-inside]')
      ?.addEventListener('click', detachTarget);

    await click('[data-test-icon]');

    assert
      .dom('[data-test-icon]')
      .doesNotExist('target was detached during bubbling');
    assert.deepEqual(calls, []);
  });
});
