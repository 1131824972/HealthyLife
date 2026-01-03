import { CommonConstants as Const } from 'common';

/**
 * BMI 体质监测组件
 * 功能：输入身高体重，计算 BMI 指数，并显示健康状态
 */
@Component
export struct BMIComponent {
  // 获取页面路由栈，用于页面跳转管理
  @Consume('pathStack') pageStack: NavPathStack;

  // 双向绑定变量：身高输入值
  @State heightVal: string = '';
  // 双向绑定变量：体重输入值
  @State weightVal: string = '';
  // 计算结果：BMI 数值
  @State bmiResult: number = 0;
  // 计算结果：健康状态描述 (支持资源引用或字符串)
  @State bmiStatus: Resource | string = '';
  // 状态条颜色：根据健康状态动态改变
  @State statusColor: ResourceColor = Color.Gray;

  /**
   * 核心算法：计算 BMI
   * 公式：BMI = 体重(kg) / (身高(m) * 身高(m))
   */
  calculateBMI() {
    // 将字符串转换为浮点数
    let h = parseFloat(this.heightVal);
    let w = parseFloat(this.weightVal);

    // 校验输入是否合法 (必须大于0)
    if (h > 0 && w > 0) {
      // 1. 单位转换：厘米 -> 米
      let h_meter = h / 100;
      // 2. 计算公式
      this.bmiResult = w / (h_meter * h_meter);

      // 3. 根据国际标准判断健康状态
      if (this.bmiResult < 18.5) {
        // 偏瘦：显示蓝色
        this.bmiStatus = $r('app.string.bmi_status_thin');
        this.statusColor = Color.Blue;
      } else if (this.bmiResult < 24) {
        // 正常：显示绿色
        this.bmiStatus = $r('app.string.bmi_status_normal');
        this.statusColor = Color.Green;
      } else {
        // 超重：显示红色
        this.bmiStatus = $r('app.string.bmi_status_overweight');
        this.statusColor = Color.Red;
      }
    } else {
      // 输入无效时的处理
      this.bmiResult = 0;
      this.bmiStatus = $r('app.string.bmi_input_error');
      this.statusColor = Color.Gray;
    }
  }

  build() {
    // NavDestination 是配合 Navigation 使用的子页面容器
    NavDestination() {
      Column({ space: 20 }) {
        // 页面标题
        Text($r('app.string.bmi_title'))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 20 })

        // 输入区域容器
        Column({ space: 15 }) {
          // 身高输入框
          TextInput({ placeholder: $r('app.string.bmi_height_placeholder'), text: this.heightVal })
            .type(InputType.Number) // 限制只能输入数字
            .width('90%')
            .height(50)
            .backgroundColor(Color.White)
            .onChange((value: string) => {
              this.heightVal = value; // 实时更新输入值
            })

          // 体重输入框
          TextInput({ placeholder: $r('app.string.bmi_weight_placeholder'), text: this.weightVal })
            .type(InputType.Number)
            .width('90%')
            .height(50)
            .backgroundColor(Color.White)
            .onChange((value: string) => {
              this.weightVal = value;
            })
        }
        .width('100%')
        .padding(10)

        // 计算按钮
        Button($r('app.string.bmi_btn_calculate'))
          .width('80%')
          .height(45)
          .backgroundColor('#007DFF')
          .onClick(() => {
            this.calculateBMI(); // 点击触发计算
          })

        // 结果展示区域 (只有计算出结果后才显示)
        if (this.bmiResult > 0) {
          Column({ space: 10 }) {
            // 显示具体的数值，保留1位小数
            Row() {
              Text($r('app.string.bmi_result_prefix'))
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
              Text(this.bmiResult.toFixed(1))
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
            }

            // 显示健康状态标签
            Row() {
              Text(this.bmiStatus)
                .fontSize(18)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Center)
            .width(150)
            .height(40)
            .backgroundColor(this.statusColor) // 动态绑定背景颜色
            .borderRadius(20)
          }
          .margin({ top: 30 })
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(16)
          .shadow({ radius: 10, color: '#1a000000', offsetY: 5 }) // 添加阴影增加立体感
          .width('90%')
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('sys.color.background_secondary')) // 使用系统二级背景色
    }
    .title($r('app.string.bmi_title')) // 导航栏标题
  }
}

// 路由构建函数 (必须导出)
@Builder
export function bmiBuilder() {
  BMIComponent()
}