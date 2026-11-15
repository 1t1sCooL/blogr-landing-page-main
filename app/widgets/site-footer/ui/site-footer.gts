import type { TOC } from '@ember/component/template-only';
import Logo from '../../../shared/ui/logo/logo.gts';
import { NAV_GROUPS } from '../../../entities/nav/index.ts';
import './site-footer.css';

interface SiteFooterSignature {
  Element: HTMLElement;
}

const headingId = (id: string): string => `footer-${id}-title`;

const SiteFooter: TOC<SiteFooterSignature> = <template>
  <footer class="site-footer" ...attributes>
    <div class="site-footer__inner container">
      <a class="site-footer__home" href="#">
        <Logo class="site-footer__logo" />
      </a>
      {{#each NAV_GROUPS key="id" as |group|}}
        <nav class="site-footer__group" aria-labelledby={{headingId group.id}}>
          <h2
            class="site-footer__heading"
            id={{headingId group.id}}
          >{{group.label}}</h2>
          <ul class="site-footer__links" role="list">
            {{#each group.links as |link|}}
              <li><a
                  class="site-footer__link"
                  href={{link.href}}
                >{{link.label}}</a></li>
            {{/each}}
          </ul>
        </nav>
      {{/each}}
    </div>
    <p class="site-footer__attribution">
      Challenge by
      <a
        href="https://www.frontendmentor.io?ref=challenge"
        target="_blank"
        rel="noopener noreferrer"
      >Frontend Mentor</a>. Coded by
      <a
        href="https://mmalabugin.ru"
        target="_blank"
        rel="noopener noreferrer"
      >1t1sCooL</a>.
    </p>
  </footer>
</template>;

export default SiteFooter;
