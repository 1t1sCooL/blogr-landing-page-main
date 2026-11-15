import type { TOC } from '@ember/component/template-only';
import ArtDirectedImage from '../../../shared/ui/art-directed-image/art-directed-image.gts';
import {
  FEATURES,
  FeatureList,
  featureTitleId,
} from '../../../entities/feature/index.ts';
import { PHONES_ILLUSTRATION } from '../model/illustration.ts';
import './infrastructure.css';

interface InfrastructureSignature {
  Element: HTMLElement;
}

const [leadFeature] = FEATURES.infrastructure;

const InfrastructureSection: TOC<InfrastructureSignature> = <template>
  <section
    class="infrastructure"
    aria-labelledby={{if leadFeature (featureTitleId leadFeature)}}
    ...attributes
  >
    <div class="infrastructure__band">
      <ArtDirectedImage
        class="infrastructure__illustration"
        @desktop={{PHONES_ILLUSTRATION}}
      />
      <FeatureList
        class="infrastructure__features"
        @features={{FEATURES.infrastructure}}
        @tone="dark"
        @size="large"
      />
    </div>
  </section>
</template>;

export default InfrastructureSection;
