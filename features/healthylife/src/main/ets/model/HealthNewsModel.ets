/**
 * Health News Data Interface
 */
export interface HealthNews {
  id: number;
  title: string;
  summary: string;
  publishTime: string;
  source: string;
}

/**
 * Mock Data Source
 * Simulates a network request to fetch health tips
 */
export class HealthNewsModel {
  /**
   * Simulate an HTTP network request using a Promise and setTimeout
   * @returns Promise<Array<HealthNews>>
   */
  getNewsList(): Promise<Array<HealthNews>> {
    return new Promise((resolve) => {
      // Simulate network delay (1 second)
      setTimeout(() => {
        const mockData: Array<HealthNews> = [
          {
            id: 1,
            title: '每天喝八杯水真的科学吗？',
            summary: '关于人体水分需求的深度解析，揭秘补水误区。',
            publishTime: '2025-01-02',
            source: '健康日报'
          },
          {
            id: 2,
            title: '早睡早起对免疫力的影响',
            summary: '充足的睡眠是免疫系统的加油站，看看专家怎么说。',
            publishTime: '2025-01-01',
            source: '生活百科'
          },
          {
            id: 3,
            title: '适合上班族的办公室拉伸操',
            summary: '拒绝久坐腰酸背痛，5分钟带你恢复活力。',
            publishTime: '2024-12-30',
            source: '运动周刊'
          },
          {
            id: 4,
            title: '冬季饮食：如何吃出健康',
            summary: '冬季进补有讲究，这些食材千万别错过。',
            publishTime: '2024-12-28',
            source: '美食与健康'
          },
          {
            id: 5,
            title: 'BMI 指数与心血管健康的关系',
            summary: '保持标准体重，远离慢性病风险。',
            publishTime: '2024-12-25',
            source: '医学前沿'
          }
        ];
        resolve(mockData);
      }, 1000); // 1000ms delay
    });
  }
}

export default new HealthNewsModel();