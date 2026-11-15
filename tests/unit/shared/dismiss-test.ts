import { module, test } from 'qunit';
import {
  isEscapeKey,
  isOutside,
} from 'blogr-landing-page-main/shared/lib/dismiss/on-dismiss.ts';

module('Unit | shared | dismiss helpers', function () {
  test('isEscapeKey recognises both modern and legacy key names', function (assert) {
    assert.true(isEscapeKey({ key: 'Escape' }));
    assert.true(isEscapeKey({ key: 'Esc' }));
    assert.false(isEscapeKey({ key: 'Enter' }));
    assert.false(isEscapeKey({ key: 'e' }));
  });

  test('isOutside is false when the element is on the event path', function (assert) {
    const root = document.createElement('div');
    const child = document.createElement('span');
    root.append(child);

    assert.false(isOutside(root, [child, root, document.body, document]));
  });

  test('isOutside is true when the element is not on the event path', function (assert) {
    const root = document.createElement('div');
    const other = document.createElement('span');

    assert.true(isOutside(root, [other, document.body, document]));
    assert.true(isOutside(root, []));
  });

  test('isOutside trusts the path even if the target was detached', function (assert) {
    const root = document.createElement('div');
    const child = document.createElement('span');
    root.append(child);
    const path = [child, root];
    child.remove();

    assert.false(root.contains(child), 'target is no longer in the element');
    assert.false(isOutside(root, path));
  });
});
