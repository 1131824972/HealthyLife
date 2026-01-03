export interface NavItem {
  icon: Resource;
  icon_selected: Resource;
  text: Resource;
  id: number;
}

export enum TabId {
  HOME = 0,
  DISCOVERY = 1, // Phase 2: Inserted Discovery
  MINE = 2       // Shifted Mine to index 2
}

export const NavList: NavItem[] = [
  {
    icon: $r('app.media.ic_tabs_home_normal'),
    icon_selected: $r('app.media.ic_tabs_home_sel'),
    text: $r('app.string.tab_home'),
    id: TabId.HOME
  },
  {
    // Reusing achievement icons for discovery to save asset space
    icon: $r('app.media.ic_tabs_achievement_normal'),
    icon_selected: $r('app.media.ic_tabs_achievement_sel'),
    text: $r('app.string.tab_discovery'),
    id: TabId.DISCOVERY
  },
  {
    icon: $r('app.media.ic_tabs_mine_normal'),
    icon_selected: $r('app.media.ic_tabs_mine_sel'),
    text: $r('app.string.tab_mine'),
    id: TabId.MINE
  }
]