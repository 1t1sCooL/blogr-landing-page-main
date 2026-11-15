import type { TOC } from '@ember/component/template-only';
import ArtDirectedImage from '../../../shared/ui/art-directed-image/art-directed-image.gts';
import { FEATURES, FeatureList } from '../../../entities/feature/index.ts';
import { LAPTOP_ILLUSTRATION } from '../model/illustration.ts';
import './tooling.css';

interface ToolingSignature {
  Element: HTMLElement;
}

const ToolingSection: TOC<ToolingSignature> = <template>
  <section class="tooling" aria-label="Open source tooling" ...attributes>
    <ArtDirectedImage
      class="tooling__illustration"
      @desktop={{LAPTOP_ILLUSTRATION.desktop}}
      @mobile={{LAPTOP_ILLUSTRATION.mobile}}
    />
    <div class="tooling__inner container">
      <FeatureList class="tooling__features" @features={{FEATURES.tooling}} />
    </div>
  </section>
</template>;

export default ToolingSection;
