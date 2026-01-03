/**
 * 健康资讯数据接口定义
 * 用于规范新闻列表的数据结构
 */
export interface HealthNews {
  id: number;
  title: Resource | string;  // 标题：支持多语言资源或字符串
  summary: Resource | string;// 摘要
  publishTime: string;       // 发布时间
  source: Resource | string; // 来源
}

/**
 * 模拟数据源模型
 * 作用：模拟从网络服务器获取 JSON 数据的过程
 */
export class HealthNewsModel {
  /**
   * 模拟 HTTP 网络请求
   * 使用 Promise 封装异步操作，模拟真实开发中的 API 调用
   * @returns Promise<Array<HealthNews>> 返回新闻数组的 Promise 对象
   */
  getNewsList(): Promise<Array<HealthNews>> {
    return new Promise((resolve) => {
      // 使用 setTimeout 模拟 1秒 的网络延迟
      setTimeout(() => {
        const mockData: Array<HealthNews> = [
          {
            id: 1,
            title: $r('app.string.news_title_1'),
            summary: $r('app.string.news_summary_1'),
            publishTime: '2025-01-02',
            source: $r('app.string.news_source_1')
          },
          {
            id: 2,
            title: $r('app.string.news_title_2'),
            summary: $r('app.string.news_summary_2'),
            publishTime: '2025-01-01',
            source: $r('app.string.news_source_2')
          },
          {
            id: 3,
            title: $r('app.string.news_title_3'),
            summary: $r('app.string.news_summary_3'),
            publishTime: '2024-12-30',
            source: $r('app.string.news_source_3')
          },
          {
            id: 4,
            title: $r('app.string.news_title_4'),
            summary: $r('app.string.news_summary_4'),
            publishTime: '2024-12-28',
            source: $r('app.string.news_source_4')
          },
          {
            id: 5,
            title: $r('app.string.news_title_5'),
            summary: $r('app.string.news_summary_5'),
            publishTime: '2024-12-25',
            source: $r('app.string.news_source_5')
          }
        ];
        // 请求成功，返回数据
        resolve(mockData);
      }, 1000); // 延迟 1000 毫秒
    });
  }
}

// 导出单例对象
export default new HealthNewsModel();