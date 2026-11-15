import type { TOC } from '@ember/component/template-only';
import ArtDirectedImage from '../../../shared/ui/art-directed-image/art-directed-image.gts';
import { FEATURES, FeatureList } from '../../../entities/feature/index.ts';
import { EDITOR_ILLUSTRATION } from '../model/illustration.ts';
import './designed-for-future.css';

interface DesignedForFutureSignature {
  Element: HTMLElement;
}

const DesignedForFuture: TOC<DesignedForFutureSignature> = <template>
  <section class="designed" aria-labelledby="designed-title" ...attributes>
    <div class="designed__inner container">
      <h2 class="designed__title" id="designed-title">Designed for the future</h2>
      <ArtDirectedImage
        class="designed__illustration"
        @desktop={{EDITOR_ILLUSTRATION.desktop}}
        @mobile={{EDITOR_ILLUSTRATION.mobile}}
      />
      <FeatureList class="designed__features" @features={{FEATURES.designed}} />
    </div>
  </section>
</template>;

export default DesignedForFuture;
