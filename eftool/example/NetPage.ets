/**
 * @Author csx
 * @DateTime 2024/7/4 23:27
 * @TODO NetPage
 */
import { http } from '@kit.NetworkKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { JSONArray, JSONObject } from '@yunkss/eftool';
import { promptAction } from '@kit.ArkUI';

export class Test {
  api_version?: object
  kind?: object
  metadata?: Metadata
  spec?: Spec
  status?: Status
}

export class Status {
  addresses?: Addresses[]
  allocatable?: Allocatable
  capacity?: Capacity
  conditions?: Conditions[]
  config?: object
  daemon_endpoints?: Daemon_endpoints
  images?: Images[]
  node_info?: Node_info
  phase?: object
  volumes_attached?: object
  volumes_in_use?: object
}

export class Node_info {
  architecture?: string
  boot_id?: string
  container_runtime_version?: string
  kernel_version?: string
  kube_proxy_version?: string
  kubelet_version?: string
  machine_id?: string
  operating_system?: string
  os_image?: string
  system_uuid?: string
}

export class Images {
  names?: string[]
  size_bytes?: number
}

export class Daemon_endpoints {
  kubelet_endpoint?: Kubelet_endpoint
}

export class Kubelet_endpoint {
  port?: number
}

export class Conditions {
  last_heartbeat_time?: string
  last_transition_time?: string
  message?: string
  reason?: string
  status?: string
  type?: string
}

export class Capacity {
  cpu?: string
  memory?: string
  pods?: string
}

export class Allocatable {
  cpu?: string
  memory?: string
  pods?: string
}

export class Addresses {
  address?: string
  type?: string
}

export class Spec {
  config_source?: object
  external_id?: object
  pod_cidr?: string
  pod_cid_rs?: string[]
  provider_id?: object
  taints?: Taints[]
  unschedulable?: object
}

export class Taints {
  effect?: string
  key?: string
  time_added?: object
  value?: object
}

export class Metadata {
  creation_timestamp?: string
  deletion_grace_period_seconds?: object
  deletion_timestamp?: object
  finalizers?: object
  generate_name?: object
  generation?: object
  name?: string
  namespace?: object
  owner_references?: object
  resource_version?: string
  self_link?: object
  uid?: string
}

@Entry
@Component
export struct NetPage {
  private cloudNodes?: Test[];

  aboutToAppear(): void {
    // this.requestData();

    let str = `{"f:spec": {"f:podCIDR": {},"f:podCIDRs": {".": {},"v:\"10.244.0.0/24\"": {}},"f:taints": {}}}`;

    let obj =  JSONObject.parse(str);

    hilog.info(0xFF00, "AAA", "Result:" + obj.get("f:podCIDR"));
  }

  requestData(): void {
    let httpRequest = http.createHttp();
    httpRequest.on('headersReceive', (header) => {
      hilog.info(0xFF00, "AAA", "header:" + JSON.stringify(header));
    });
    httpRequest.request(
      "http://123.249.25.203:30850/cloudedge/node/cloudnode",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        hilog.info(0xFF00, "AAA", "Result:" + JSON.stringify(data.result));
        hilog.info(0xFF00, "AAA", "code:" + JSON.stringify(data.responseCode));
        if (data.responseCode == 200) {
          //成功
          this.cloudNodes = JSONArray.parseArray<Test>(data.result as string);
          // this.cloudNodes.forEach(item => {
          //   hilog.info(0xFF00,"AAA","xxx:" + item.status.node_info.os_image);
          // })
          hilog.info(0xFF00, "AAA", "xxx:" + this.cloudNodes.length);
        } else {
          promptAction.showToast({ message: "服务器数据异常!", duration: 2000 })
        }

      } else {
        //网络或服务器异常
        promptAction.showToast({ message: "网络或服务器异常!", duration: 2000 })
        hilog.info(0xFF00, "AAA", "error:" + JSON.stringify(err));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁
        httpRequest.destroy();
      }
    }
    );
  }

  build() {
  }
}