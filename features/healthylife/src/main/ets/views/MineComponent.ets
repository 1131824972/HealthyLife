import { CommonConstants as Const } from 'common';
import { UserInfoComponent } from './mine/UserInfoComponent';

@Component
export struct MineComponent {
  @Provide uiContext: UIContext = this.getUIContext();
  @Consume('pathStack') pageStack: NavPathStack;

  build() {
    Navigation() {
      Column() {
        UserInfoComponent()

        // ... (保持原来的 "个人资料" Row 不变) ...
        Row({ space: $r('app.float.default_16') }) {
          Image($r('app.media.book_closed_per'))
            .width($r('app.float.default_24'))
            .height($r('app.float.default_24'))
          Text($r('app.string.mine_personal_data'))
            .fontColor($r('app.color.mine_font_color'))
            .fontSize($r('app.float.default_18'))
            .fontWeight(FontWeight.Medium)
          Blank();
          SymbolGlyph($r('sys.symbol.chevron_right'))
            .fontColor([$r('sys.color.icon_fourth')])
            .fontWeight(FontWeight.Normal)
            .fontSize($r('app.float.default_24'))
        }
        .width(Const.THOUSANDTH_940)
        .height(Const.THOUSANDTH_100)
        .borderRadius({
          topLeft: $r('app.float.default_16'),
          topRight: $r('app.float.default_16')
        })
        .padding({
          left: $r('app.float.default_12'),
          right: $r('app.float.default_12')
        })
        .backgroundColor($r('sys.color.background_primary'))
        .margin({
          top: $r('app.float.default_6')
        })

        Divider()
          .color($r('app.float.default_1'))
          .width(Const.THOUSANDTH_880)

        // ... (保持原来的 "检查更新" Row 不变) ...
        Row({ space: $r('app.float.default_16') }) {
          Image($r('app.media.arrow_up_circle'))
            .width($r('app.float.default_24'))
            .height($r('app.float.default_24'))
          Text($r('app.string.mine_check_updates'))
            .fontColor($r('app.color.mine_font_color'))
            .fontSize($r('app.float.default_18'))
            .fontWeight(FontWeight.Medium)
          Blank();
          SymbolGlyph($r('sys.symbol.chevron_right'))
            .fontColor([$r('sys.color.icon_fourth')])
            .fontWeight(FontWeight.Normal)
            .fontSize($r('app.float.default_24'))
        }
        .width(Const.THOUSANDTH_940)
        .height(Const.THOUSANDTH_100)
        .padding({
          left: $r('app.float.default_12'),
          right: $r('app.float.default_12')
        })
        .backgroundColor($r('sys.color.background_primary'))
        .margin({
          bottom: $r('app.float.default_6')
        })

        // ... (保持原来的 "成就" Row 不变) ...
        Row({ space: $r('app.float.default_16') }) {
          Image($r('app.media.star_trophy'))
            .width($r('app.float.default_24'))
            .height($r('app.float.default_24'))
          Text($r('app.string.mine_achievement'))
            .fontColor($r('app.color.mine_font_color'))
            .fontSize($r('app.float.default_18'))
            .fontWeight(FontWeight.Medium)
          Blank();
          SymbolGlyph($r('sys.symbol.chevron_right'))
            .fontColor([$r('sys.color.icon_fourth')])
            .fontWeight(FontWeight.Normal)
            .fontSize($r('app.float.default_24'))
        }
        .width(Const.THOUSANDTH_940)
        .height(Const.THOUSANDTH_100)
        .borderRadius({
          bottomLeft: $r('app.float.default_16'),
          bottomRight: $r('app.float.default_16')
        })
        .padding({
          left: $r('app.float.default_12'),
          right: $r('app.float.default_12')
        })
        .backgroundColor($r('sys.color.background_primary'))
        .margin({
          top: $r('app.float.default_6')
        })
        .onClick(() => {
          this.pageStack.pushPathByName('AchievementComponent', '');
        })

        // ======= 新增：BMI 监测入口 =======
        Row({ space: $r('app.float.default_16') }) {
          // 这里暂时复用一个图标，如果找不到 scale 图标可以使用 resource 中已有的
          Image($r('app.media.ic_tabs_home_sel'))
            .width($r('app.float.default_24'))
            .height($r('app.float.default_24'))
          Text("BMI 体质监测") // 这里可以直接写字符串，后续可移入 string.json
            .fontColor($r('app.color.mine_font_color'))
            .fontSize($r('app.float.default_18'))
            .fontWeight(FontWeight.Medium)
          Blank();
          SymbolGlyph($r('sys.symbol.chevron_right'))
            .fontColor([$r('sys.color.icon_fourth')])
            .fontWeight(FontWeight.Normal)
            .fontSize($r('app.float.default_24'))
        }
        .width(Const.THOUSANDTH_940)
        .height(Const.THOUSANDTH_100)
        .borderRadius($r('app.float.default_16'))
        .padding({
          left: $r('app.float.default_12'),
          right: $r('app.float.default_12')
        })
        .backgroundColor($r('sys.color.background_primary'))
        .margin({
          top: $r('app.float.default_12')
        })
        .onClick(() => {
          // 跳转到 BMI 页面
          this.pageStack.pushPathByName('BMIComponent', null);
        })
        // ================================
      }
      .width(Const.THOUSANDTH_1000)
      .height(Const.THOUSANDTH_1000)
    }
    .title($r('app.string.tab_mine'))
    .backgroundColor($r('sys.color.background_secondary'))
  }
}