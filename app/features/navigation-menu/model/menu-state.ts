import { tracked } from '@glimmer/tracking';
import type { NavGroupId } from '../../../entities/nav/index.ts';

export const toggleId = <T>(current: T | null, id: T): T | null =>
  current === id ? null : id;

export const menuToggleLabel = (isOpen: boolean): string =>
  isOpen ? 'Close menu' : 'Open menu';

export class MenuState {
  @tracked openGroupId: NavGroupId | null = null;
  @tracked isMobileOpen = false;

  get isAnyOpen(): boolean {
    return this.isMobileOpen || this.openGroupId !== null;
  }

  isGroupOpen = (id: NavGroupId): boolean => this.openGroupId === id;

  toggleGroup = (id: NavGroupId): void => {
    this.openGroupId = toggleId(this.openGroupId, id);
  };

  toggleMobile = (): void => {
    this.isMobileOpen = !this.isMobileOpen;
    if (!this.isMobileOpen) this.openGroupId = null;
  };

  closeAll = (): void => {
    this.openGroupId = null;
    this.isMobileOpen = false;
  };
}
