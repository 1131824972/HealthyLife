import { HomeComponent } from '../views/HomeComponent';
import { MineComponent } from '../views/MineComponent';
import { DiscoveryComponent } from '../views/DiscoveryComponent'; // [新增] 导入发现组件
import { NavList, TabId } from '../model/NavItemModel';
import { CommonConstants as Const, convertDate2Str } from 'common';
import DayInfoApi from 'common/src/main/ets/database/tables/DayInfoApi';
import { AchievementStore, initAchievementStore } from '../viewmodel/AchievementStore';
import { HomeStore } from '../viewmodel/HomeStore';
import { common } from '@kit.AbilityKit';

/**
 * 应用主入口页面
 * 包含底部 Tab 导航栏和对应的三个子页面内容
 */
@Component
export struct HealthyLifePage {
  // 当前选中的 Tab 索引，默认为 0 (首页)
  @State currentIndex: number = 0;
  // 状态管理：成就数据
  @Provide achievementStore: AchievementStore = new AchievementStore(0, 0, false);
  // 路由栈管理
  @Provide('pathStack') pageStack: NavPathStack = new NavPathStack();
  // 状态管理：主页数据
  @Provide homeStore: HomeStore = new HomeStore([], -1, '', []);

  private context = this.getUIContext()?.getHostContext() as common.UIAbilityContext;
  private windowClass = this.context.windowStage.getMainWindowSync();

  // 页面初始化生命周期
  async aboutToAppear(): Promise<void> {
    try {
      // 设置全屏沉浸式显示，透明状态栏
      await this.windowClass.setWindowLayoutFullScreen(true);
      await this.windowClass.setWindowSystemBarProperties({
        statusBarColor: '#00000000',
        statusBarContentColor: '#FF000000'
      })
    } catch (error) {
      console.error(`an error occurred: ${error}`);
    }
    // 初始化当天的数据库信息
    await DayInfoApi.initDayInfo(convertDate2Str(new Date()));
    // 初始化成就数据
    this.achievementStore = await initAchievementStore();
  }

  build() {
    // 根容器：导航组件
    Navigation(this.pageStack) {
      // 底部标签栏组件
      Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {

        // Tab 1: 首页
        TabContent() {
          HomeComponent()
        }
        .tabBar(this.tabBuilder(TabId.HOME))

        // Tab 2: 发现页
        TabContent() {
          DiscoveryComponent()
        }
        .tabBar(this.tabBuilder(TabId.DISCOVERY))

        // Tab 3: 我的
        TabContent() {
          MineComponent()
        }
        .tabBar(this.tabBuilder(TabId.MINE))
      }
      .backgroundColor($r('sys.color.background_secondary'))
      .scrollable(false) // 禁止左右滑动切换
      .width(Const.THOUSANDTH_1000)
      .height(Const.THOUSANDTH_1000)
      .barWidth(Const.THOUSANDTH_940)
      .vertical(false)
      .padding({
        bottom: $r('app.float.default_20')
      })
      .divider({
        strokeWidth: 1,
        color: $r('sys.color.background_tertiary')
      })
      // 监听 Tab 切换事件，更新当前索引
      .onChange((index) => {
        this.currentIndex = index;
      })
    }
    .mode(NavigationMode.Stack) // 导航模式设为栈模式
  }

  // 自定义 TabBar 构建函数
  @Builder
  tabBuilder(index: number) {
    Column() {
      // 动态显示选中/未选中图标
      Image(index === this.currentIndex ? NavList[index].icon_selected : NavList[index].icon)
        .width($r('app.float.default_24'))
        .height($r('app.float.default_24'))
        .objectFit(ImageFit.Contain);

      // 动态显示选中/未选中文字颜色
      Text(NavList[index].text)
        .fontSize($r('app.float.default_10'))
        .fontWeight(FontWeight.Regular)
        .fontColor(this.currentIndex === index ? $r('app.color.text_font_color') : $r('sys.color.font_tertiary'))
        .margin({
          top: $r('app.float.default_4')
        })
    }
    .justifyContent(FlexAlign.Center)
    .width(Const.THOUSANDTH_1000)
    .height(Const.THOUSANDTH_1000)
  }
}