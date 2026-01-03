import { CommonConstants as Const } from 'common';
import preferences from '@ohos.data.preferences';
import { common } from '@kit.AbilityKit';

@Component
export struct UserInfoComponent {
  @State nickname: string = '';
  @State signature: string = '运动总有新玩法'; // 默认签名
  private context = getContext(this) as common.UIAbilityContext;

  // 用于编辑昵称的弹窗控制器
  dialogController: CustomDialogController = new CustomDialogController({
    builder: NicknameEditDialog({
      textValue: $nickname,
      confirm: (value: string) => {
        this.saveNickname(value);
      }
    }),
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -20 }
  });

  async aboutToAppear() {
    // 组件加载时读取持久化的昵称
    await this.getNickname();
  }

  // 读取昵称
  async getNickname() {
    try {
      let promise = preferences.getPreferences(this.context, 'healthy_life_prefs');
      let pref = await promise;
      // 读取 'nickname'，如果不存在则使用默认值 'Jolin' (从资源中获取)
      let defaultName = await this.context.resourceManager.getStringValue($r('app.string.user_name'));
      let value = await pref.get('nickname', defaultName);
      this.nickname = value.toString();
    } catch (err) {
      console.error('Failed to get preferences.', err);
      // 降级处理：直接从资源读取
      this.nickname = 'Jolin'; // 这里为了保险起见，如果读资源失败，直接用字符串
    }
  }

  // 保存昵称
  async saveNickname(value: string) {
    if (!value || value.trim() === '') {
      return;
    }
    try {
      this.nickname = value;
      let promise = preferences.getPreferences(this.context, 'healthy_life_prefs');
      let pref = await promise;
      await pref.put('nickname', value);
      await pref.flush(); // 必须调用 flush 刷入磁盘
      console.info('Succeeded in saving nickname.');
    } catch (err) {
      console.error('Failed to save preferences.', err);
    }
  }

  build() {
    Row() {
      Image($r('app.media.ic_user'))
        .width($r('app.float.default_48'))
        .height($r('app.float.default_48'))
        .objectFit(ImageFit.Contain)
        .margin({ right: $r('app.float.default_12') })

      Column() {
        // 点击昵称触发修改
        Row() {
          Text(this.nickname)
            .fontSize($r('app.float.default_20'))
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black) // 修复：直接使用 Color.Black 替代 app.color.title_color

          // 添加一个小图标提示可编辑
          Image($r('sys.media.ohos_ic_public_edit')) // 使用系统自带编辑图标
            .width(16)
            .height(16)
            .margin({ left: 8 })
            .fillColor(Color.Gray)
        }
        .onClick(() => {
          this.dialogController.open();
        })

        Text(this.signature)
          .fontSize($r('app.float.default_14'))
          .fontColor(Color.Gray) // 修复：直接使用 Color.Gray 替代可能不存在的颜色资源
          .opacity(0.6)
          .margin({ top: $r('app.float.default_4') })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width(Const.THOUSANDTH_1000)
    .padding({
      left: $r('app.float.default_24'),
      right: $r('app.float.default_24'),
      top: $r('app.float.default_24'),
      bottom: $r('app.float.default_24')
    })
    .backgroundColor($r('sys.color.background_primary'))
  }
}

// 自定义弹窗组件
@CustomDialog
struct NicknameEditDialog {
  controller?: CustomDialogController;
  @Link textValue: string;
  confirm?: (value: string) => void;
  @State inputValue: string = '';

  aboutToAppear() {
    this.inputValue = this.textValue;
  }

  build() {
    Column() {
      Text($r('app.string.nickname_edit'))
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      TextInput({ placeholder: $r('app.string.nickname_input_placeholder'), text: this.inputValue })
        .height(50)
        .width('90%')
        .onChange((value: string) => {
          this.inputValue = value;
        })
        .margin({ bottom: 20 })

      Row() {
        Button($r('app.string.cancel'))
          .onClick(() => {
            this.controller?.close();
          })
          .backgroundColor(Color.White)
          .fontColor(Color.Black)
          .width('40%')

        Button($r('app.string.confirm'))
          .onClick(() => {
            if (this.confirm) {
              this.confirm(this.inputValue);
            }
            this.controller?.close();
          })
          .backgroundColor('#007DFF') // 使用十六进制颜色避免依赖
          .fontColor(Color.White)
          .width('40%')
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
      .margin({ bottom: 20 })
    }
    .backgroundColor(Color.White)
    .borderRadius(16)
    .width('80%')
  }
}