import type { TOC } from '@ember/component/template-only';
import { MOBILE_MEDIA } from '../../config/media.ts';

export interface ImageAsset {
  readonly src: string;
  readonly width: number;
  readonly height: number;
}

interface ArtDirectedImageSignature {
  Element: HTMLImageElement;
  Args: {
    desktop: ImageAsset;
    mobile?: ImageAsset;
    alt?: string;
  };
}

const ArtDirectedImage: TOC<ArtDirectedImageSignature> = <template>
  <picture class="art-directed-image">
    {{#if @mobile}}
      <source
        media={{MOBILE_MEDIA}}
        srcset={{@mobile.src}}
        width={{@mobile.width}}
        height={{@mobile.height}}
      />
    {{/if}}
    <img
      src={{@desktop.src}}
      width={{@desktop.width}}
      height={{@desktop.height}}
      alt={{if @alt @alt ""}}
      loading="lazy"
      decoding="async"
      ...attributes
    />
  </picture>
</template>;

export default ArtDirectedImage;
