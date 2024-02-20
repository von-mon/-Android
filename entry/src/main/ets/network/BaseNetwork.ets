import http from '@ohos.net.http';
import BaseResponse from '../data/BaseResponse'

const baseURL = "https://www.wanandroid.com/"

export class RequestParam {
  url: string
  param ?: object | string | number
  get:boolean = false

  constructor(url: string, param?: object | string | number, get: boolean = false) {
    // 组装URL
    this.url = baseURL + url
    this.param = param
    this.get = get
  }
}

// @ts-ignore
export default async function postData<T>(request: RequestParam): Promise<BaseResponse<T>> {
  let dataList:BaseResponse<T> = new BaseResponse()
  let httpRequest = http.createHttp()
  let response = httpRequest.request(
    request.url,
    {
      method: request.get ? http.RequestMethod.GET : http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: {
        "data": request.param,
      },
      usingCache: true, // 可选，默认为true
      priority: 1, // 可选，默认为1
      connectTimeout: 60000, // 可选，默认为60000ms
      readTimeout: 60000, // 可选，默认为60000ms
      usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
      expectDataType: http.HttpDataType.STRING
    }
  );
  await response.then(data => {
    const code = data.responseCode
    if (code == 200) {
      const response = JSON.parse(data.result+"")
      dataList = response
    }
  }).catch(err => {
    console.info('error:' + JSON.stringify(err))
  })
  return dataList
}