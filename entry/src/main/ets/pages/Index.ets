
import { net,IDataListener } from '../network/BaseNetwork'
import {HomePage }from './HomePage'
import {Tree }from './Tree'
import {Market }from './Market'
import {Project }from './Project'

const tabList = [
  {
    title:"首页",
    img:$r('app.media.home'),
    checkImg:$r('app.media.ic_home_checked'),
  },
  {
    title:"体系",
    img:$r('app.media.tree'),
    checkImg:$r('app.media.ic_tree_checked'),
  },
  {
    title:"项目",
    img:$r('app.media.project'),
    checkImg:$r('app.media.ic_project_checked'),
  },
  {
    title:"广场",
    img:$r('app.media.market'),
    checkImg:$r('app.media.ic_market_checked'),
  }
]

@Entry
@Component
struct Index {
  private controller: TabsController = new TabsController()
  @State currentIndex:number = 0
  build() {
    Tabs({barPosition:BarPosition.End,controller:this.controller}) {
      TabContent() {
          HomePage()
      }.tabBar(this.TabBuilder(0))
      TabContent() {
        Tree()
      }.tabBar(this.TabBuilder(1))
      TabContent() {
        Project()
      }.tabBar(this.TabBuilder(2))
      TabContent() {
        Market()
      }.tabBar(this.TabBuilder(3))
    }
  }

  @Builder
  TabBuilder(index:number) {
    Column() {
      Image(this.currentIndex === index ? tabList[index].checkImg:tabList[index].img)
        .size({ width: 24, height: 24 })
      Text(tabList[index].title)
        .fontColor(this.currentIndex === index ? $r('app.color.themeColor') : $r('app.color.black'))
    }
    .onClick(() => {
      this.currentIndex = index
      this.controller.changeIndex(index)
    })
  }

}