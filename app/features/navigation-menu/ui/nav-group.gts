import type { TOC } from '@ember/component/template-only';
import { on } from '@ember/modifier';
import { fn } from '@ember/helper';
import IconChevron from '../../../shared/ui/icons/icon-chevron.gts';
import type { NavGroup, NavGroupId } from '../../../entities/nav/index.ts';
import './nav-group.css';

interface NavGroupSignature {
  Element: HTMLLIElement;
  Args: {
    group: NavGroup;
    isOpen: boolean;
    onToggle: (id: NavGroupId) => void;
  };
}

const menuId = (group: NavGroup): string => `nav-menu-${group.id}`;

const NavGroupItem: TOC<NavGroupSignature> = <template>
  <li class="nav-group {{if @isOpen 'is-open'}}" ...attributes>
    <button
      class="nav-group__trigger"
      type="button"
      aria-expanded={{if @isOpen "true" "false"}}
      aria-controls={{menuId @group}}
      {{on "click" (fn @onToggle @group.id)}}
    >
      <span class="nav-group__label">{{@group.label}}</span>
      <IconChevron class="nav-group__chevron" />
    </button>
    <ul
      class="nav-group__menu"
      id={{menuId @group}}
      role="list"
      hidden={{if @isOpen false true}}
    >
      {{#each @group.links as |link|}}
        <li><a
            class="nav-group__link"
            href={{link.href}}
          >{{link.label}}</a></li>
      {{/each}}
    </ul>
  </li>
</template>;

export default NavGroupItem;
