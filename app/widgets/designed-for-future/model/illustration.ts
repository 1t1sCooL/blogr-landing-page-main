import { assetUrl } from '../../../shared/config/assets.ts';
import type { ImageAsset } from '../../../shared/ui/art-directed-image/art-directed-image.gts';

export const EDITOR_ILLUSTRATION: {
  readonly desktop: ImageAsset;
  readonly mobile: ImageAsset;
} = {
  desktop: {
    src: assetUrl('images/illustration-editor-desktop.svg'),
    width: 925,
    height: 882,
  },
  mobile: {
    src: assetUrl('images/illustration-editor-mobile.svg'),
    width: 406,
    height: 331,
  },
};
