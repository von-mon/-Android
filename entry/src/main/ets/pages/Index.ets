import postData, { RequestParam } from '../network/BaseNetwork'
import HomeArticleResponse, { DataItem } from '../data/HomeArticleResponse'
import {ListView, RefreshController} from '@app/refresh'
import {LoadingDialog} from '../dialog/LoadingDialog'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State dataList: DataItem[] = []
  @State count:number = 0
  @State controller: RefreshController = new RefreshController() //刷新控制器
  private loading = new CustomDialogController({
    builder: LoadingDialog(),
    alignment: DialogAlignment.Center,
    offset: ({ dx: 0, dy: 0 }),
    autoCancel: false,
    customStyle: true
  })
  async aboutToAppear() {
    this.getData(this.count)
  }

  async getData(count:number) {
    this.loading.open()
    const list = await postData<HomeArticleResponse>(new RequestParam(`article/list/${count}/json`, "", true))
    console.log(JSON.stringify(list))
    if (this.dataList.length == 0) {
      this.dataList = list.data.datas
    } else {
     this.dataList = this.dataList.concat(list.data.datas)
    }
    this.loading.close()
    console.log(this.dataList.length+"")
  };

  build() {
    Column() {
      ListView({
        items: this.dataList,
        itemLayout: (item, index) => this.articleItemLayout(item, index),
        controller: this.controller,
        onRefresh: () => {
          this.count = 0
          this.dataList.length = 0
          this.getData(this.count)
          this.controller.finishRefresh()
        },
        onLoadMore: () => {
          this.count++
          console.log(this.count + "")
          this.getData(this.count)
          this.controller.finishLoadMore()
        }
      })

    }
    .backgroundColor($r('app.color.HomeBg'))
  }

  @Builder
  articleItemLayout(item, index) {
    Row(){
      Column() {
        Text(item.title)
          .fontSize(18)
          .fontStyle(FontStyle.Normal)
          .fontWeight(600)
          .padding(16)
          .alignSelf(ItemAlign.Start)

        Row(){
          Text(`作者: ${item.author}`)
            .margin({right:8})
          Text(`时间: ${item.niceDate}`)
        }
        .alignSelf(ItemAlign.Start)
        .margin({left:16})
      }
      .layoutWeight(1)
      .backgroundColor(Color.White)
      .height('20%')
      .margin({left:16,right:16})
      .borderRadius(16)
    }
    .width('100%')
    .margin({top:16})
  }

  @Builder
  waitDialog(show:boolean) {

  }
}