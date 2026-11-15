import type { TOC } from '@ember/component/template-only';
import ButtonLink from '../../../shared/ui/button-link/button-link.gts';
import './intro.css';

interface IntroSignature {
  Element: HTMLElement;
}

const Intro: TOC<IntroSignature> = <template>
  <section class="intro" aria-labelledby="intro-title" ...attributes>
    <div class="intro__content container">
      <h1 class="intro__title" id="intro-title">A modern publishing platform</h1>
      <p class="intro__lead">Grow your audience and build your online brand</p>
      <div class="intro__actions">
        <ButtonLink @href="#">Start for Free</ButtonLink>
        <ButtonLink @href="#" @variant="outline">Learn More</ButtonLink>
      </div>
    </div>
  </section>
</template>;

export default Intro;
