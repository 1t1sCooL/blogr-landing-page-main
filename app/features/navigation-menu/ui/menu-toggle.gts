import type { TOC } from '@ember/component/template-only';
import { on } from '@ember/modifier';
import IconHamburger from '../../../shared/ui/icons/icon-hamburger.gts';
import IconClose from '../../../shared/ui/icons/icon-close.gts';
import { menuToggleLabel } from '../model/menu-state.ts';
import './menu-toggle.css';

interface MenuToggleSignature {
  Element: HTMLButtonElement;
  Args: {
    isOpen: boolean;
    controls: string;
    onToggle: () => void;
  };
}

const MenuToggle: TOC<MenuToggleSignature> = <template>
  <button
    class="menu-toggle"
    type="button"
    aria-expanded={{if @isOpen "true" "false"}}
    aria-controls={{@controls}}
    aria-label={{menuToggleLabel @isOpen}}
    {{on "click" @onToggle}}
    ...attributes
  >
    {{#if @isOpen}}
      <IconClose />
    {{else}}
      <IconHamburger />
    {{/if}}
  </button>
</template>;

export default MenuToggle;
