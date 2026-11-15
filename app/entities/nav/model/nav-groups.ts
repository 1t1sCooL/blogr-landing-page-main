export type NavGroupId = 'product' | 'company' | 'connect';

export interface NavLink {
  readonly label: string;
  readonly href: string;
}

export interface NavGroup {
  readonly id: NavGroupId;
  readonly label: string;
  readonly links: readonly NavLink[];
}

const toLinks = (labels: readonly string[]): readonly NavLink[] =>
  labels.map((label) => ({ label, href: '#' }));

export const NAV_GROUPS: readonly NavGroup[] = [
  {
    id: 'product',
    label: 'Product',
    links: toLinks([
      'Overview',
      'Pricing',
      'Marketplace',
      'Features',
      'Integrations',
    ]),
  },
  {
    id: 'company',
    label: 'Company',
    links: toLinks(['About', 'Team', 'Blog', 'Careers']),
  },
  {
    id: 'connect',
    label: 'Connect',
    links: toLinks(['Contact', 'Newsletter', 'LinkedIn']),
  },
];

export const AUTH_LINKS = {
  login: { label: 'Login', href: '#' },
  signUp: { label: 'Sign Up', href: '#' },
} as const satisfies Record<string, NavLink>;

export const findNavGroup = (
  id: NavGroupId,
  groups: readonly NavGroup[] = NAV_GROUPS,
): NavGroup | undefined => groups.find((group) => group.id === id);
