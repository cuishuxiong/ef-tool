import { PrefUtil } from './PrefUtil';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct PrefIndex {
  @State vo:keyValue = {key:'测试',value:'测试001'}
  build() {
    Column({space:10}) {
        comButton({
          title: '创建首选项', action: () => {
            PrefUtil.init()
            promptAction.showToast({message:'创建首选项成功'})
          }
        })
        comButton({
          title: '插入首选项——key:ass,value:我是测试数据02', action: () => {
            PrefUtil.setValue('ass','我是测试数据02')
            promptAction.showToast({message:'插入首选项字符串成功'})
          }
        })
        comButton({
          title: '查询首选项——key:ass', action: () => {
            const res = PrefUtil.getValueStr('ass')
            promptAction.showToast({message:'查询出来的结果：'+res})
          }
        })
        comButton({
          title: '修改首选项——key:ass,value:我是测试数据999', action: () => {
            PrefUtil.setValue('ass','我是测试数据999')
            promptAction.showToast({message:'修改成功'})
          }
        })
        comButton({
          title: '删除首选项——key:ass', action: () => {
            PrefUtil.delValue('ass')
            promptAction.showToast({message:'删除成功'})
          }
        })
        comButton({
          title: '删除整个首选项', action: () => {
            PrefUtil.delDefStroePrimose(getContext(this))
            promptAction.showToast({message:'删除整个首选项成功'})
          }
        })
      comButton({
        title: '插入首选项对象——key:ass,value:{key:"测试",value:"测试001"}', action: () => {
          PrefUtil.setValue('ass',JSON.stringify(this.vo))
          promptAction.showToast({message:'插入首选项对象成功'})
        }
      })
      comButton({
        title: '查询首选项对象——key:ass', action: () => {
          const res = PrefUtil.getValueT<keyValue>('ass',new keyValue())
          promptAction.showToast({message:'查询出来的结果：'+JSON.stringify(res)})
        }
      })
      comButton({
        title: '修改首选项对象——key:ass', action: () => {
          this.vo.key = '我是测试数据999'
          this.vo.value = '我是测试数据999'
          PrefUtil.setValue('ass',JSON.stringify(this.vo))
          promptAction.showToast({message:'修改成功'})
        }
      })

    }
    .height('100%')
    .width('100%').justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}


//公共button
@Component
struct comButton{
  @State
  title:string = ''//button文本
  action: () => void = ()=>{}
  build() {
    Row() {
      Button(this.title, { type: ButtonType.Normal })
        .backgroundColor(Color.Green)
        .borderRadius(6)
        .width('50%')
        .height(30)
        .onClick(()=>{
          this.action()
        })
    }.justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .width('100%')
  }
}

export class keyValue {
  key: ResourceStr = ''
  value: ResourceStr = ''
}