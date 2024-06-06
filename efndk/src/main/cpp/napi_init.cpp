#include "napi/native_api.h"
#include <hilog/log.h>

/**
 * 生成deskey
 * @param env
 * @param info
 * @return
 */
static napi_value encodeECB(napi_env env, napi_callback_info info) {
    if ((nullptr == env) || (nullptr == info)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, 0xFF00, "MyHypot", "env or exports is null");
        return nullptr;
    }

    // Number of parameters.
    size_t argc = 2;

    // Declare parameter array.
    napi_value args[2] = {nullptr};

    // Gets the arguments passed in and puts them in the argument array.
    if (napi_ok != napi_get_cb_info(env, info, &argc, args, nullptr, nullptr)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, 0xFF00, "MyHypot", "api_get_cb_info failed");
        return nullptr;
    }

   
    napi_value napiResult;
   
    return napiResult;
}

static napi_value decodeECB(napi_env env, napi_callback_info info) {
    if ((nullptr == env) || (nullptr == info)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, 0xFF00, "MyHypot", "env or exports is null");
        return nullptr;
    }
    // Number of parameters.
    size_t argc = 2;

    // Declare parameter array.
    napi_value args[2] = {nullptr};

    // Gets the arguments passed in and puts them in the argument array.
    if (napi_ok != napi_get_cb_info(env, info, &argc, args, nullptr, nullptr)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, 0xFF00, "MyHypot", "api_get_cb_info failed");
        return nullptr;
    }


    napi_value napiResult;

    return napiResult;
}

static napi_value encodeCBC(napi_env env, napi_callback_info info) {
    if ((nullptr == env) || (nullptr == info)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, 0xFF00, "MyHypot", "env or exports is null");
        return nullptr;
    }
    // Number of parameters.
    size_t argc = 2;

    // Declare parameter array.
    napi_value args[2] = {nullptr};

    // Gets the arguments passed in and puts them in the argument array.
    if (napi_ok != napi_get_cb_info(env, info, &argc, args, nullptr, nullptr)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, 0xFF00, "MyHypot", "api_get_cb_info failed");
        return nullptr;
    }


    napi_value napiResult;

    return napiResult;
}

static napi_value decodeCBC(napi_env env, napi_callback_info info) {
    if ((nullptr == env) || (nullptr == info)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, 0xFF00, "MyHypot", "env or exports is null");
        return nullptr;
    }

    // Number of parameters.
    size_t argc = 2;

    // Declare parameter array.
    napi_value args[2] = {nullptr};

    // Gets the arguments passed in and puts them in the argument array.
    if (napi_ok != napi_get_cb_info(env, info, &argc, args, nullptr, nullptr)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, 0xFF00, "MyHypot", "api_get_cb_info failed");
        return nullptr;
    }


    napi_value napiResult;

    return napiResult;
}

/**
 * Native C++模板生成的结构
 * @param env
 * @param exports
 * @return
 */
EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports)
{
    if ((nullptr == env) || (nullptr == exports)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, 0xFF00, "Init", "env or exports is null");
        return exports;
    }
    /**
     * 需要将编写的自定义方法与对外提供的接口xxxxx接口进行关联
     */
    napi_property_descriptor desc[] = {
        {"encodeECB", nullptr, encodeECB, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"decodeECB", nullptr, decodeECB, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"encodeCBC", nullptr, encodeCBC, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"decodeCBC", nullptr, decodeCBC, nullptr, nullptr, nullptr, napi_default, nullptr}
    };
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

/**
 * 配置模块描述信息，设置Init方法为napi_module的入口方法。
 */
static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "efndk",
    .nm_priv = ((void*)0),
    .reserved = { 0 },
};

/**
 * 系统自动调用，使用NAPI接口napi_module_register()传入模块描述信息进行模块注册
 */
extern "C" __attribute__((constructor)) void RegisterEfndkModule(void)
{
    napi_module_register(&demoModule);
}
