import type { TOC } from '@ember/component/template-only';

interface IconChevronSignature {
  Element: SVGSVGElement;
}

const IconChevron: TOC<IconChevronSignature> = <template>
  <svg
    class="icon-chevron"
    xmlns="http://www.w3.org/2000/svg"
    width="10"
    height="7"
    viewBox="0 0 10 7"
    aria-hidden="true"
    focusable="false"
    ...attributes
  >
    <path fill="none" stroke="currentColor" stroke-width="2" d="M1 1l4 4 4-4" />
  </svg>
</template>;

export default IconChevron;
