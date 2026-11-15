import type { TOC } from '@ember/component/template-only';

interface IconHamburgerSignature {
  Element: SVGSVGElement;
}

const IconHamburger: TOC<IconHamburgerSignature> = <template>
  <svg
    class="icon-hamburger"
    xmlns="http://www.w3.org/2000/svg"
    width="32"
    height="18"
    viewBox="0 0 32 18"
    aria-hidden="true"
    focusable="false"
    ...attributes
  >
    <path fill="currentColor" d="M0 0h32v2H0zM0 8h32v2H0zM0 16h32v2H0z" />
  </svg>
</template>;

export default IconHamburger;
