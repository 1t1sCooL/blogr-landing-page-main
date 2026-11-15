import { module, test } from 'qunit';
import {
  FEATURES,
  featureTitleId,
} from 'blogr-landing-page-main/entities/feature/index.ts';

module('Unit | entities | features', function () {
  test('groups match the sections of the design', function (assert) {
    assert.deepEqual(
      FEATURES.designed.map((feature) => feature.title),
      ['Introducing an extensible editor', 'Robust content management'],
    );
    assert.deepEqual(
      FEATURES.infrastructure.map((feature) => feature.title),
      ['State of the Art Infrastructure'],
    );
    assert.deepEqual(
      FEATURES.tooling.map((feature) => feature.title),
      ['Free, open, simple', 'Powerful tooling'],
    );
  });

  test('feature ids are unique across all groups', function (assert) {
    const ids = Object.values(FEATURES)
      .flat()
      .map((feature) => feature.id);
    assert.strictEqual(new Set(ids).size, ids.length);
  });

  test('every feature has body copy', function (assert) {
    for (const feature of Object.values(FEATURES).flat()) {
      assert.true(feature.text.length > 50, `${feature.id} has text`);
    }
  });

  test('featureTitleId builds a stable DOM id', function (assert) {
    assert.strictEqual(featureTitleId({ id: 'abc' }), 'feature-abc-title');
  });
});
