import { module, test } from 'qunit';
import { render } from '@ember/test-helpers';
import { setupRenderingTest } from 'blogr-landing-page-main/tests/helpers/index.ts';
import { LandingPage } from 'blogr-landing-page-main/pages/landing/index.ts';

module('Integration | pages | LandingPage', function (hooks) {
  setupRenderingTest(hooks);

  test('composes landmarks in document order', async function (assert) {
    await render(<template><LandingPage /></template>);

    const root = document.querySelector('.landing-page');
    assert.deepEqual(
      [...(root?.children ?? [])].map((element) =>
        element.tagName.toLowerCase(),
      ),
      ['header', 'main', 'footer'],
    );
    assert.deepEqual(
      [...document.querySelectorAll('main > section')].map(
        (section) => section.className,
      ),
      ['intro', 'designed', 'infrastructure', 'tooling'],
    );
  });

  test('has a single h1 and a logical heading outline', async function (assert) {
    await render(<template><LandingPage /></template>);

    assert.dom('h1').exists({ count: 1 });
    assert.dom('main h2').exists({ count: 1 });
    assert.dom('main h3').exists({ count: 5 });
    assert.dom('footer h2').exists({ count: 3 });
  });

  test('every DOM id is unique', async function (assert) {
    await render(<template><LandingPage /></template>);

    const ids = [...document.querySelectorAll('.landing-page [id]')].map(
      (element) => element.id,
    );
    assert.strictEqual(new Set(ids).size, ids.length);
  });

  test('every aria reference points to an existing element', async function (assert) {
    await render(<template><LandingPage /></template>);

    const references = [
      ...document.querySelectorAll('[aria-labelledby], [aria-controls]'),
    ].flatMap((element) =>
      [
        element.getAttribute('aria-labelledby'),
        element.getAttribute('aria-controls'),
      ].filter((id): id is string => Boolean(id)),
    );
    assert.true(references.length > 0);
    for (const id of references) {
      assert.dom(`#${id}`).exists(`#${id} exists`);
    }
  });
});
