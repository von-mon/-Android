@Preview
@CustomDialog
export struct LoadingDialog {
  @State index:number = 0;
  controller: CustomDialogController;
  aboutToAppear() {
    //定时器
    setInterval(() => {
      this.index = this.index + 10
    }, 300);
  }
  build() {
    Progress({ value: this.index, total: 100, type: ProgressType.Ring })
      .color(Color.Blue).value(this.index).width(100)
      .style({ strokeWidth: 20, scaleCount: 30, scaleWidth: 50 })
      .backgroundColor(Color.White)
  }
}