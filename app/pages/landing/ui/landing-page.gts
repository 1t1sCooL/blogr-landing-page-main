import type { TOC } from '@ember/component/template-only';
import { SiteHeader } from '../../../widgets/site-header/index.ts';
import { Intro } from '../../../widgets/intro/index.ts';
import { DesignedForFuture } from '../../../widgets/designed-for-future/index.ts';
import { InfrastructureSection } from '../../../widgets/infrastructure/index.ts';
import { ToolingSection } from '../../../widgets/tooling/index.ts';
import { SiteFooter } from '../../../widgets/site-footer/index.ts';
import './landing-page.css';

const LandingPage: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="landing-page" ...attributes>
    <SiteHeader />
    <main>
      <Intro />
      <DesignedForFuture />
      <InfrastructureSection />
      <ToolingSection />
    </main>
    <SiteFooter />
  </div>
</template>;

export default LandingPage;
