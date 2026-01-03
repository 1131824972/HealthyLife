/**
 * 底部导航栏数据接口
 */
export interface NavItem {
  icon: Resource;          // 未选中时的图标
  icon_selected: Resource; // 选中时的图标
  text: Resource;          // 文字标题
  id: number;              // 唯一标识 ID
}

/**
 * Tab ID 枚举
 * 定义了底部的三个页面索引
 */
export enum TabId {
  HOME = 0,      // 首页
  DISCOVERY = 1, // 发现页
  MINE = 2       // 我的
}

/**
 * 导航栏配置列表
 */
export const NavList: NavItem[] = [
  {
    icon: $r('app.media.ic_tabs_home_normal'),
    icon_selected: $r('app.media.ic_tabs_home_sel'),
    text: $r('app.string.tab_home'),
    id: TabId.HOME
  },
  {
    // 发现页配置
    // 复用成就(Achievement)的图标资源，避免缺失
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