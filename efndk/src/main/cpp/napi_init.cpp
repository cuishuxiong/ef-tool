#include "napi/native_api.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <hilog/log.h>
#include <openssl/des.h>
#include <string>

static napi_value Add(napi_env env, napi_callback_info info) {
    size_t argc = 2;
    napi_value args[2] = {nullptr};

    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);

    napi_valuetype valuetype0;
    napi_typeof(env, args[0], &valuetype0);

    napi_valuetype valuetype1;
    napi_typeof(env, args[1], &valuetype1);

    double value0;
    napi_get_value_double(env, args[0], &value0);

    double value1;
    napi_get_value_double(env, args[1], &value1);

    napi_value sum;
    napi_create_double(env, value0 + value1, &sum);

    return sum;
}

static napi_value EncodeCBC(napi_env env, napi_callback_info info) {
    // 返回加密结果
    napi_value napiResult;
    // 获取入参
    size_t argc = 2;
    napi_value args[2] = {nullptr};
    // 实际赋值
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);
    // 获取des的key
    char key[256];
    size_t keyLen;
    napi_status stKey = napi_get_value_string_utf8(env, args[0], key, sizeof(key), &keyLen);
    if (stKey != napi_ok) {
        char msg[] = "读取入参key失败~~~";
        napi_create_string_utf8(env, msg, sizeof(msg), &napiResult);
    }
    // 获取待加密的字符串
    char str[256];
    size_t strLen;
    napi_status stStr = napi_get_value_string_utf8(env, args[1], str, sizeof(str), &strLen);
    if (stStr != napi_ok) {
        char msg[] = "读取入参待加密字符串失败~~~";
        napi_create_string_utf8(env, msg, sizeof(msg), &napiResult);
    }

    napi_create_string_utf8(env, key, sizeof(key), &napiResult);
//     napi_create_string_utf8(env, str, sizeof(str), &napiResult);

    // 开始加密
    //  将密钥字符串转换为DES_cblock
    //     DES_cblock keyCblock;
    //     memcpy(keyCblock, key, sizeof(key));

    // 将数据字符串转换为DES_cblock
    //     DES_cblock data;
    //     memcpy(data, str, sizeof(str));

    // 加密数据
    //     DES_key_schedule sch;
    //     DES_set_key_unchecked(&keyCblock, &sch);
    //     DES_ecb_encrypt(&data, &data, &sch, DES_ENCRYPT);


    //     napi_create_string_utf8(env, reinterpret_cast<const char *>(&data), sizeof(&data), &napiResult);

    return napiResult;
}


static napi_value EncodeECB(napi_env env, napi_callback_info info) {
    //
    //     //     DES_ecb_encrypt(const_DES_cblock *input, DES_cblock *output, DES_key_schedule *ks, int enc)
    //
    //     // Number of parameters.
    // //     size_t argc = 0;
    //
    //     // argv 传入 nullptr 来获取传入参数真实数量
    // //     napi_get_cb_info(env, info, &argc, nullptr, nullptr, nullptr);
    //     // JS 传入参数为0，不执行后续逻辑
    // //     if (argc == 0) {
    // //         return nullptr;
    // //     }
    //
    //     // Declare parameter array.
    //     // 创建数组用以获取JS传入的参数
    // //     napi_value *argv = new napi_value[argc];
    //
    // //     napi_get_cb_info(env, info, &argc, argv, nullptr, nullptr);
    //
    // //     napi_valuetype strType;
    // //     napi_typeof(env, argv[0], &strType);
    //
    // //     napi_valuetype keyType;
    // //     napi_typeof(env, argv[1], &keyType);
    //
    napi_value napiResult;
    //
    //
    napi_create_string_utf8(env, "您好这是返回的字符串", 100, &napiResult);
    //
    //     // argv 为 new 创建的对象，在使用完成后手动释放
    //     //     delete argv;
    //
    return napiResult;
}

EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports) {
    napi_property_descriptor desc[] = {
        {"add", nullptr, Add, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"encodeECB", nullptr, EncodeECB, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"encodeCBC", nullptr, EncodeCBC, nullptr, nullptr, nullptr, napi_default, nullptr},
    };
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "efndk",
    .nm_priv = ((void *)0),
    .reserved = {0},
};

extern "C" __attribute__((constructor)) void RegisterEfndkModule(void) { napi_module_register(&demoModule); }
