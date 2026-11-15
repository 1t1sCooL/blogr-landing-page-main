import type { TOC } from '@ember/component/template-only';
import FeatureArticle from './feature-article.gts';
import type { Feature } from '../model/features.ts';
import './feature-list.css';

interface FeatureListSignature {
  Element: HTMLDivElement;
  Args: {
    features: readonly Feature[];
    tone?: 'light' | 'dark';
    size?: 'regular' | 'large';
  };
}

const FeatureList: TOC<FeatureListSignature> = <template>
  <div class="feature-list" ...attributes>
    {{#each @features key="id" as |feature|}}
      <FeatureArticle @feature={{feature}} @tone={{@tone}} @size={{@size}} />
    {{/each}}
  </div>
</template>;

export default FeatureList;
