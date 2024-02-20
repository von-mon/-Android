import postData, { RequestParam } from '../network/BaseNetwork'
import HomeArticleResponse from '../data/HomeArticleResponse'
import { ListView } from '@app/refresh/src/main/ets/ListView'
import { RefreshController } from '@app/refresh/src/main/ets/controller/RefreshController'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State dataList: HomeArticleResponse[] = []
  @State controller: RefreshController = new RefreshController() //刷新控制器
  async aboutToAppear() {
    const list = await postData<HomeArticleResponse[]>(new RequestParam("article/list/0/json", "", true))
    this.dataList = list.data
  }

  build() {
    Column() {
      ListView({
        items: this.dataList,
        itemLayout: (item, index) => this.articleItemLayout(item, index),
        controller: this.controller,
        onRefresh: () => {
          this.controller.finishRefresh()
        },
        onLoadMore: () => {
          this.controller.finishLoadMore()
        }
      })
    }
  }

  @Builder
  articleItemLayout(item, index) {
    Column() {
      Text(item.author)
    }
  }
}