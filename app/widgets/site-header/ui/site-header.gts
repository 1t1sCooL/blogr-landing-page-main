import type { TOC } from '@ember/component/template-only';
import Logo from '../../../shared/ui/logo/logo.gts';
import { NavigationMenu } from '../../../features/navigation-menu/index.ts';
import './site-header.css';

interface SiteHeaderSignature {
  Element: HTMLElement;
}

const SiteHeader: TOC<SiteHeaderSignature> = <template>
  <header class="site-header" ...attributes>
    <div class="site-header__bar container">
      <a class="site-header__home" href="#">
        <Logo class="site-header__logo" />
      </a>
      <NavigationMenu />
    </div>
  </header>
</template>;

export default SiteHeader;
