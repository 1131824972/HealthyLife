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

        // 个人资料
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

        // 检查更新
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

        // 成就
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

        // ======= BMI 监测入口 (Fixed) =======
        Row({ space: $r('app.float.default_16') }) {
          Image($r('app.media.ic_tabs_home_sel'))
            .width($r('app.float.default_24'))
            .height($r('app.float.default_24'))
          // [修复] 使用资源引用代替硬编码
          Text($r('app.string.entry_bmi'))
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