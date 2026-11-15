import type { TOC } from '@ember/component/template-only';
import NavGroupItem from './nav-group.gts';
import ButtonLink from '../../../shared/ui/button-link/button-link.gts';
import {
  AUTH_LINKS,
  NAV_GROUPS,
  type NavGroupId,
} from '../../../entities/nav/index.ts';
import './site-nav.css';

interface SiteNavSignature {
  Element: HTMLElement;
  Args: {
    isOpen: boolean;
    isGroupOpen: (id: NavGroupId) => boolean;
    onToggleGroup: (id: NavGroupId) => void;
  };
}

export const SITE_NAV_ID = 'site-nav';

const SiteNav: TOC<SiteNavSignature> = <template>
  <nav
    class="site-nav {{if @isOpen 'is-open'}}"
    id={{SITE_NAV_ID}}
    aria-label="Primary"
    ...attributes
  >
    <ul class="site-nav__groups" role="list">
      {{#each NAV_GROUPS as |group|}}
        <NavGroupItem
          @group={{group}}
          @isOpen={{@isGroupOpen group.id}}
          @onToggle={{@onToggleGroup}}
        />
      {{/each}}
    </ul>
    <div class="site-nav__auth">
      <a
        class="site-nav__login"
        href={{AUTH_LINKS.login.href}}
      >{{AUTH_LINKS.login.label}}</a>
      <ButtonLink class="site-nav__signup" @href={{AUTH_LINKS.signUp.href}}>
        {{AUTH_LINKS.signUp.label}}
      </ButtonLink>
    </div>
  </nav>
</template>;

export default SiteNav;
