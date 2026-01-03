import HealthNewsModel, { HealthNews } from '../model/HealthNewsModel';
import { CommonConstants as Const } from 'common';

@Component
export struct DiscoveryComponent {
  @State newsList: Array<HealthNews> = [];
  @State isLoading: boolean = true;

  // Simulate "fetching data from network" when the component appears
  aboutToAppear() {
    this.isLoading = true;
    HealthNewsModel.getNewsList().then((data) => {
      this.newsList = data;
      this.isLoading = false;
    });
  }

  build() {
    Column() {
      // Header
      Text($r('app.string.tab_discovery'))
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 20, top: 20, bottom: 10 })
        .backgroundColor($r('sys.color.background_secondary'))

      // Loading State
      if (this.isLoading) {
        Column() {
          LoadingProgress()
            .width(60)
            .height(60)
            .color('#007DFF')
          Text('正在获取健康资讯...')
            .fontSize(14)
            .fontColor(Color.Gray)
            .margin({ top: 10 })
        }
        .width('100%')
        .height('80%')
        .justifyContent(FlexAlign.Center)
      } else {
        // News List
        List({ space: 12 }) {
          ForEach(this.newsList, (item: HealthNews) => {
            ListItem() {
              Column({ space: 8 }) {
                Row() {
                  Text(item.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .layoutWeight(1)

                  // Tag/Source
                  Text(item.source)
                    .fontSize(12)
                    .fontColor(Color.White)
                    .backgroundColor('#007DFF')
                    .padding({ left: 8, right: 8, top: 2, bottom: 2 })
                    .borderRadius(4)
                }
                .width('100%')
                .alignItems(VerticalAlign.Center)

                Text(item.summary)
                  .fontSize(14)
                  .fontColor($r('sys.color.font_secondary'))
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .lineHeight(20)

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
              .backgroundColor($r('sys.color.background_primary'))
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1a000000', offsetY: 2 })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, bottom: 16 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('sys.color.background_secondary'))
  }
}