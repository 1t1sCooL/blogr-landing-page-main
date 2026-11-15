import type { TOC } from '@ember/component/template-only';
import { featureTitleId, type Feature } from '../model/features.ts';
import './feature-article.css';

interface FeatureArticleSignature {
  Element: HTMLElement;
  Args: {
    feature: Feature;
    tone?: 'light' | 'dark';
    size?: 'regular' | 'large';
  };
}

const FeatureArticle: TOC<FeatureArticleSignature> = <template>
  <article
    class="feature-article feature-article--{{if @tone @tone 'light'}}
      feature-article--{{if @size @size 'regular'}}"
    aria-labelledby={{featureTitleId @feature}}
    ...attributes
  >
    <h3
      class="feature-article__title"
      id={{featureTitleId @feature}}
    >{{@feature.title}}</h3>
    <p class="feature-article__text">{{@feature.text}}</p>
  </article>
</template>;

export default FeatureArticle;
