@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button("click me")
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.message = "米好啊"
          })
        Button("change me")
          .type(ButtonType.Circle)
          .width(160)
          .fontSize(20)
          .height(160)
          .margin(20)
          .onClick(() => {
            this.message = "Hello World"
          })

        List(){
          ListItem(){
            Text("sadas")
          }
        }
      }
      .width('100%')

    }
    .height('100%')
  }
}