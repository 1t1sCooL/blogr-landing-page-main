import { module, test } from 'qunit';
import {
  AUTH_LINKS,
  NAV_GROUPS,
  findNavGroup,
  type NavGroup,
} from 'blogr-landing-page-main/entities/nav/index.ts';

module('Unit | entities | nav groups', function () {
  test('exposes the three groups from the design in order', function (assert) {
    assert.deepEqual(
      NAV_GROUPS.map((group) => group.label),
      ['Product', 'Company', 'Connect'],
    );
  });

  test('every group has unique ids and non-empty links', function (assert) {
    const ids = NAV_GROUPS.map((group) => group.id);
    assert.strictEqual(new Set(ids).size, ids.length);
    for (const group of NAV_GROUPS) {
      assert.true(group.links.length > 0, `${group.id} has links`);
      for (const link of group.links) {
        assert.true(link.label.length > 0);
        assert.strictEqual(link.href, '#');
      }
    }
  });

  test('contains the links listed in the design', function (assert) {
    assert.deepEqual(
      findNavGroup('product')?.links.map((link) => link.label),
      ['Overview', 'Pricing', 'Marketplace', 'Features', 'Integrations'],
    );
    assert.deepEqual(
      findNavGroup('company')?.links.map((link) => link.label),
      ['About', 'Team', 'Blog', 'Careers'],
    );
    assert.deepEqual(
      findNavGroup('connect')?.links.map((link) => link.label),
      ['Contact', 'Newsletter', 'LinkedIn'],
    );
  });

  test('findNavGroup searches a custom collection', function (assert) {
    const groups: NavGroup[] = [{ id: 'company', label: 'Custom', links: [] }];
    assert.strictEqual(findNavGroup('company', groups)?.label, 'Custom');
    assert.strictEqual(findNavGroup('product', groups), undefined);
  });

  test('auth links', function (assert) {
    assert.strictEqual(AUTH_LINKS.login.label, 'Login');
    assert.strictEqual(AUTH_LINKS.signUp.label, 'Sign Up');
  });
});
