// 文件名: features/healthylife/src/main/ets/views/BMIComponent.ets

import { CommonConstants as Const } from 'common';

@Component
export struct BMIComponent {
  @Consume('pathStack') pageStack: NavPathStack;
  @State heightVal: string = '';
  @State weightVal: string = '';
  @State bmiResult: number = 0;
  @State bmiStatus: string = '';
  @State statusColor: ResourceColor = Color.Gray;

  calculateBMI() {
    let h = parseFloat(this.heightVal);
    let w = parseFloat(this.weightVal);

    if (h > 0 && w > 0) {
      // 身高单位转换 cm -> m
      let h_meter = h / 100;
      this.bmiResult = w / (h_meter * h_meter);

      if (this.bmiResult < 18.5) {
        this.bmiStatus = '偏瘦';
        this.statusColor = Color.Blue;
      } else if (this.bmiResult < 24) {
        this.bmiStatus = '正常';
        this.statusColor = Color.Green;
      } else {
        this.bmiStatus = '超重';
        this.statusColor = Color.Red;
      }
    } else {
      this.bmiResult = 0;
      this.bmiStatus = '请输入有效数值';
      this.statusColor = Color.Gray;
    }
  }

  build() {
    NavDestination() {
      Column({ space: 20 }) {
        // 标题
        Text('BMI 体质监测')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 20 })

        // 输入区域
        Column({ space: 15 }) {
          TextInput({ placeholder: '请输入身高 (cm)', text: this.heightVal })
            .type(InputType.Number)
            .width('90%')
            .height(50)
            .backgroundColor(Color.White)
            .onChange((value: string) => {
              this.heightVal = value;
            })

          TextInput({ placeholder: '请输入体重 (kg)', text: this.weightVal })
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

        // 按钮
        Button('开始计算')
          .width('80%')
          .height(45)
          // 【修复点】原代码使用了不存在的资源，现改为直接使用十六进制颜色（鸿蒙蓝）
          .backgroundColor('#007DFF')
          .onClick(() => {
            this.calculateBMI();
          })

        // 结果显示
        if (this.bmiResult > 0) {
          Column({ space: 10 }) {
            Text(`您的 BMI 值: ${this.bmiResult.toFixed(1)}`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)

            Row() {
              Text(this.bmiStatus)
                .fontSize(18)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Center)
            .width(100)
            .height(40)
            .backgroundColor(this.statusColor)
            .borderRadius(20)
          }
          .margin({ top: 30 })
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(16)
          .shadow({ radius: 10, color: '#1a000000', offsetY: 5 })
          .width('90%')
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('sys.color.background_secondary'))
    }
    .title('BMI计算')
  }
}

// 必须导出 Builder 函数供 router_map 调用
@Builder
export function bmiBuilder() {
  BMIComponent()
}