// 时间格式化
// time单位的毫秒 要输出分钟和秒 格式 00:00
export const sa_timeFormat = (time: number) => {
  // 分钟
  const minutes = Math.floor(time / 1000 / 60)
  //   秒
  const seconds = (Math.floor(time / 1000) % 60).toString().padStart(2, '0')
  return `${minutes}:${seconds}`
}

// 防抖工具函数
export const sa_throttle = <T = null>(callback: Function, time: number) => {
  let tid = -1
  const retFunction = (...args: T[]) => {
    if (tid !== -1) {
      clearTimeout(tid)
    }
    tid = setTimeout(() => {
      callback(args)
    }, time)
  }

  return retFunction
}
// 获取指定范围的随机数
export const getRandomFromRange = (min: number, max: number) => {
  return Math.floor(Math.random() * (max - min + 1) + min)
}