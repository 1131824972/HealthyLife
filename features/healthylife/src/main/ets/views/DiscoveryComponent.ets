import HealthNewsModel, { HealthNews } from '../model/HealthNewsModel';
import { CommonConstants as Const } from 'common';

/**
 * 发现页面组件 (Discovery Tab)
 * 功能：异步加载并展示健康资讯列表
 */
@Component
export struct DiscoveryComponent {
  // 新闻列表数据源
  @State newsList: Array<HealthNews> = [];
  // 页面加载状态标记：true=正在加载, false=加载完成
  @State isLoading: boolean = true;

  // 生命周期：组件即将显示时触发
  aboutToAppear() {
    this.isLoading = true;
    // 调用 Model 层的异步方法获取数据
    HealthNewsModel.getNewsList().then((data) => {
      // 数据获取成功，更新状态
      this.newsList = data;
      this.isLoading = false; // 关闭 Loading 动画
    });
  }

  build() {
    Column() {
      // 顶部标题栏
      Text($r('app.string.tab_discovery'))
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 20, top: 20, bottom: 10 })
        .backgroundColor($r('sys.color.background_secondary'))

      // 条件渲染：根据 isLoading 状态决定显示 Loading 还是 列表
      if (this.isLoading) {
        // --- 加载中状态 UI ---
        Column() {
          // 鸿蒙自带的加载进度条组件
          LoadingProgress()
            .width(60)
            .height(60)
            .color('#007DFF')
          Text($r('app.string.loading_news'))
            .fontSize(14)
            .fontColor(Color.Gray)
            .margin({ top: 10 })
        }
        .width('100%')
        .height('80%')
        .justifyContent(FlexAlign.Center) // 垂直居中
      } else {
        // --- 数据列表 UI ---
        List({ space: 12 }) {
          // 循环渲染新闻列表
          ForEach(this.newsList, (item: HealthNews) => {
            ListItem() {
              // 单个新闻卡片布局
              Column({ space: 8 }) {
                // 标题栏：标题 + 来源标签
                Row() {
                  Text(item.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis }) // 超出省略号
                    .layoutWeight(1) // 占据剩余空间

                  // 来源标签
                  Text(item.source)
                    .fontSize(12)
                    .fontColor(Color.White)
                    .backgroundColor('#007DFF')
                    .padding({ left: 8, right: 8, top: 2, bottom: 2 })
                    .borderRadius(4)
                }
                .width('100%')
                .alignItems(VerticalAlign.Center)

                // 摘要内容
                Text(item.summary)
                  .fontSize(14)
                  .fontColor($r('sys.color.font_secondary'))
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .lineHeight(20)

                // 底部发布时间
                Row() {
                  Blank()
                  Text(item.publishTime)
                    .fontSize(12)
                    .fontColor(Color.Gray)
                }
                .width('100%')
              }
              .width('100%')
              .padding(16)
              .backgroundColor($r('sys.color.background_primary')) // 卡片背景色
              .borderRadius(12) // 卡片圆角
              .shadow({ radius: 4, color: '#1a000000', offsetY: 2 }) // 卡片阴影
            }
          })
        }
        .width('100%')
        .layoutWeight(1) // 列表占据剩余高度，确保可以滚动
        .padding({ left: 16, right: 16, bottom: 16 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('sys.color.background_secondary'))
  }
}