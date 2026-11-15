import type { TOC } from '@ember/component/template-only';
import { assetUrl } from '../../config/assets.ts';

interface LogoSignature {
  Element: HTMLImageElement;
}

const src = assetUrl('images/logo.svg');

const Logo: TOC<LogoSignature> = <template>
  <img
    class="logo"
    src={{src}}
    alt="Blogr"
    width="101"
    height="40"
    ...attributes
  />
</template>;

export default Logo;
