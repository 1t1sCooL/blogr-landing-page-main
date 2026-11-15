export default {
  extends: ['stylelint-config-standard'],
  rules: {
    // BEM: block, block__element, block--modifier
    'selector-class-pattern': [
      '^[a-z][a-z0-9]*(-[a-z0-9]+)*(__[a-z0-9]+(-[a-z0-9]+)*)?(--[a-z0-9]+(-[a-z0-9]+)*)?$',
      { resolveNestedSelectors: true },
    ],
    // Desktop-first breakpoints are written as max-width queries.
    'media-feature-range-notation': 'prefix',
    // iOS Safari still needs the prefixed text-size-adjust.
    'property-no-vendor-prefix': [
      true,
      { ignoreProperties: ['/text-size-adjust$/'] },
    ],
    'import-notation': 'string',
    'custom-property-empty-line-before': null,
  },
};
