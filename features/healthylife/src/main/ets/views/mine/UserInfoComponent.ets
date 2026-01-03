import { CommonConstants as Const } from 'common';
import preferences from '@ohos.data.preferences'; // 导入首选项模块
import { common } from '@kit.AbilityKit';

/**
 * 用户信息头部组件
 * 功能：展示头像、昵称，支持点击修改昵称并持久化存储
 */
@Component
export struct UserInfoComponent {
  @State nickname: string = ''; // 昵称状态
  @State signature: string = '运动总有新玩法'; // 签名（默认）
  private context = getContext(this) as common.UIAbilityContext;

  // 自定义弹窗控制器：用于显示修改昵称的对话框
  dialogController: CustomDialogController = new CustomDialogController({
    builder: NicknameEditDialog({
      textValue: $nickname, // 双向绑定，将当前昵称传给弹窗
      confirm: (value: string) => {
        // 点击确定后的回调：保存新昵称
        this.saveNickname(value);
      }
    }),
    alignment: DialogAlignment.Center, // 居中显示
    offset: { dx: 0, dy: -20 }
  });

  // 组件生命周期：加载时执行
  async aboutToAppear() {
    // 组件显示前，从本地存储读取昵称
    await this.getNickname();
  }

  /**
   * [持久化-读取] 从 Preferences 读取昵称
   */
  async getNickname() {
    try {
      // 1. 获取名为 'healthy_life_prefs' 的首选项实例
      let promise = preferences.getPreferences(this.context, 'healthy_life_prefs');
      let pref = await promise;

      // 2. 从资源文件获取默认昵称 'Jolin'，作为读取不到时的备选值
      let defaultName = await this.context.resourceManager.getStringValue($r('app.string.user_name'));

      // 3. 读取键为 'nickname' 的值
      let value = await pref.get('nickname', defaultName);

      // 4. 更新 UI 状态
      this.nickname = value.toString();
    } catch (err) {
      console.error('Failed to get preferences.', err);
      // 读取失败时的降级处理
      this.nickname = 'Jolin';
    }
  }

  /**
   * [持久化-写入] 将新昵称保存到 Preferences
   */
  async saveNickname(value: string) {
    // 简单的非空校验
    if (!value || value.trim() === '') {
      return;
    }
    try {
      // 1. 立即更新 UI
      this.nickname = value;

      // 2. 获取首选项实例
      let promise = preferences.getPreferences(this.context, 'healthy_life_prefs');
      let pref = await promise;

      // 3. 写入数据
      await pref.put('nickname', value);

      // 4. [关键] 必须调用 flush() 才能将内存数据持久化写入磁盘
      await pref.flush();
      console.info('Succeeded in saving nickname.');
    } catch (err) {
      console.error('Failed to save preferences.', err);
    }
  }

  build() {
    Row() {
      // 用户头像 (静态资源)
      Image($r('app.media.ic_user'))
        .width($r('app.float.default_48'))
        .height($r('app.float.default_48'))
        .objectFit(ImageFit.Contain)
        .margin({ right: $r('app.float.default_12') })

      Column() {
        // 昵称行：点击触发修改弹窗
        Row() {
          Text(this.nickname)
            .fontSize($r('app.float.default_20'))
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black) // 使用标准黑色，修复资源引用错误

          // 编辑图标提示
          Image($r('sys.media.ohos_ic_public_edit'))
            .width(16)
            .height(16)
            .margin({ left: 8 })
            .fillColor(Color.Gray)
        }
        .onClick(() => {
          this.dialogController.open(); // 打开弹窗
        })

        // 签名文字 (暂不支持修改)
        Text(this.signature)
          .fontSize($r('app.float.default_14'))
          .fontColor(Color.Gray)
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

/**
 * 自定义弹窗：修改昵称
 */
@CustomDialog
struct NicknameEditDialog {
  controller?: CustomDialogController;
  @Link textValue: string; // 与父组件双向绑定
  confirm?: (value: string) => void; // 确认回调函数
  @State inputValue: string = ''; // 弹窗内的临时输入状态

  aboutToAppear() {
    this.inputValue = this.textValue; // 初始化输入框内容
  }

  build() {
    Column() {
      // 弹窗标题
      Text($r('app.string.nickname_edit'))
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })

      // 输入框
      TextInput({ placeholder: $r('app.string.nickname_input_placeholder'), text: this.inputValue })
        .height(50)
        .width('90%')
        .onChange((value: string) => {
          this.inputValue = value;
        })
        .margin({ bottom: 20 })

      // 按钮区域
      Row() {
        // 取消按钮
        Button($r('app.string.cancel'))
          .onClick(() => {
            this.controller?.close();
          })
          .backgroundColor(Color.White)
          .fontColor(Color.Black)
          .width('40%')

        // 确定按钮
        Button($r('app.string.confirm'))
          .onClick(() => {
            if (this.confirm) {
              this.confirm(this.inputValue); // 将输入值回传给父组件
            }
            this.controller?.close();
          })
          .backgroundColor('#007DFF')
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