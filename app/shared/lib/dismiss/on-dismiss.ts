import { modifier } from 'ember-modifier';

export type DismissReason = 'outside' | 'escape';

export type DismissHandler = (
  reason: DismissReason,
  element: HTMLElement,
) => void;

export const isEscapeKey = (event: Pick<KeyboardEvent, 'key'>): boolean =>
  event.key === 'Escape' || event.key === 'Esc';

// The path is snapshotted at dispatch time, so it stays correct even when a
// re-render detaches the original target before the event reaches document.
export const isOutside = (
  element: Element,
  path: readonly EventTarget[],
): boolean => !path.includes(element);

interface OnDismissSignature {
  Element: HTMLElement;
  Args: {
    Positional: [handler: DismissHandler];
    Named: { enabled?: boolean };
  };
}

export const onDismiss = modifier<OnDismissSignature>(
  (element, [handler], { enabled = true }) => {
    if (!enabled) return;

    const handleClick = (event: MouseEvent) => {
      if (isOutside(element, event.composedPath())) handler('outside', element);
    };
    const handleKeydown = (event: KeyboardEvent) => {
      if (isEscapeKey(event)) handler('escape', element);
    };

    document.addEventListener('click', handleClick);
    document.addEventListener('keydown', handleKeydown);

    return () => {
      document.removeEventListener('click', handleClick);
      document.removeEventListener('keydown', handleKeydown);
    };
  },
);
