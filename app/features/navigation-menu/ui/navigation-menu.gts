import Component from '@glimmer/component';
import MenuToggle from './menu-toggle.gts';
import SiteNav, { SITE_NAV_ID } from './site-nav.gts';
import { MenuState } from '../model/menu-state.ts';
import {
  onDismiss,
  type DismissHandler,
} from '../../../shared/lib/dismiss/on-dismiss.ts';
import './navigation-menu.css';

interface NavigationMenuSignature {
  Element: HTMLDivElement;
}

const expandedTrigger = (root: HTMLElement): HTMLElement | null =>
  root.querySelector<HTMLElement>('[aria-expanded="true"]');

export default class NavigationMenu extends Component<NavigationMenuSignature> {
  state = new MenuState();

  handleDismiss: DismissHandler = (reason, element) => {
    const trigger = reason === 'escape' ? expandedTrigger(element) : null;
    this.state.closeAll();
    trigger?.focus();
  };

  <template>
    <div
      class="navigation-menu"
      {{onDismiss this.handleDismiss enabled=this.state.isAnyOpen}}
      ...attributes
    >
      <MenuToggle
        @isOpen={{this.state.isMobileOpen}}
        @controls={{SITE_NAV_ID}}
        @onToggle={{this.state.toggleMobile}}
      />
      <SiteNav
        @isOpen={{this.state.isMobileOpen}}
        @isGroupOpen={{this.state.isGroupOpen}}
        @onToggleGroup={{this.state.toggleGroup}}
      />
    </div>
  </template>
}
