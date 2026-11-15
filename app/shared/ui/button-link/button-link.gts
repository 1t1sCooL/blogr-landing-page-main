import type { TOC } from '@ember/component/template-only';
import './button-link.css';

export type ButtonVariant = 'solid' | 'outline' | 'gradient';

interface ButtonLinkSignature {
  Element: HTMLAnchorElement;
  Args: {
    href: string;
    variant?: ButtonVariant;
  };
  Blocks: { default: [] };
}

const ButtonLink: TOC<ButtonLinkSignature> = <template>
  <a
    class="button-link button-link--{{if @variant @variant 'solid'}}"
    href={{@href}}
    ...attributes
  >{{yield}}</a>
</template>;

export default ButtonLink;
