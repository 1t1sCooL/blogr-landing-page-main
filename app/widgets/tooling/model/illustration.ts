import { assetUrl } from '../../../shared/config/assets.ts';
import type { ImageAsset } from '../../../shared/ui/art-directed-image/art-directed-image.gts';

export const LAPTOP_ILLUSTRATION: {
  readonly desktop: ImageAsset;
  readonly mobile: ImageAsset;
} = {
  desktop: {
    src: assetUrl('images/illustration-laptop-desktop.svg'),
    width: 974,
    height: 786,
  },
  mobile: {
    src: assetUrl('images/illustration-laptop-mobile.svg'),
    width: 498,
    height: 359,
  },
};
