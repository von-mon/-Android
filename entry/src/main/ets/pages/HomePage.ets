import { ListView, RefreshController } from '@app/refresh'
import HomeArticleResponse, { DataItem } from '../data/HomeArticleResponse'
import { LoadingDialog } from '../dialog/LoadingDialog'
import postData, { net, RequestParam } from '../network/BaseNetwork'

const tabList = [{
  icon:$r('app.media.home'),
  name:'首页'
},
  {
    icon:$r('app.media.tree'),
    name:'体系'
  },
  {
    icon:$r('app.media.project'),
    name:'项目'
  },
  {
    icon:$r('app.media.market'),
    name:'广场'
  },
]

@Entry
@Component
export struct HomePage {
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

    net.test({onSuccess:() => {

    },onError:()=>{

    }})
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
        .layoutWeight(1)
    }
    .backgroundColor($r('app.color.HomeBg'))
    .height('100%')
    .width('100%')
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