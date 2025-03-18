import http from "@/utils/ajax/http";
import { useRoute } from "vue-router";
import { useUserStore } from "@/stores";
import { reactive, ref, unref } from "vue";
import rule from "@/utils/rule";
import { extend, isArray } from "@/utils/extend";
import { ElMessageBox } from "element-plus";
import router from "@/router";
import event from "@/utils/event";

/**
 * 响应式的对象数据
 */

export const YishengCreateForm = () => {
    var route = unref(router.currentRoute);
    const userStore = useUserStore();
    const $session = userStore.session;
    if (!route.query) {
        route = useRoute();
    }
    const form = {
        zhanghao: "",
        mima: "",
        xingming: "",
        zhicheng: "",
        youxiang: "",
        shouji: "",
        zhaopian: "",
        jianjie: "",
    };

    return form;
};

/**
 * 异步模式获取数据
 * @param id
 * @param readMap
 * @return {Promise}
 */
export const canYishengCreateForm = () => {
    return new Promise(async (resolve, reject) => {
        var form = YishengCreateForm();
        resolve({ form });
    });
};

/**
 * 响应式获取医生 模块的表单字段数据
 * @return {UnwrapNestedRefs<{}>}
 */
export const useYishengCreateForm = () => {
    const form = YishengCreateForm();
    const formReactive = reactive(form);

    return { form: formReactive };
};

export const canYishengSelect = (filter, result) => {
    http.post("/api/yisheng/selectPages").then((res) => {
        if (res.code == 0) {
            extend(result, res.data);
        } else {
            ElMessageBox.alert(res.msg);
        }
    });
};

/**
 * 获取分页数据
 * @param filter
 */
export const useYishengSelect = (filter) => {
    const result = reactive({
        lists: [],
        total: {},
    });
    canYishengSelect(filter, result);
    return result;
};

/**
 * 根据
 * @param id
 * @return {Promise|form}
 */
export const canYishengFindById = (id) => {
    return new Promise((resolve, reject) => {
        // 读取后台数据
        http.get("/api/yisheng/findById", { id }).then((res) => {
            if (res.code == 0) {
                resolve(res.data);
            } else {
                reject(new Error(res.msg));
            }
        }, reject);
    });
};

/**
 * 根据id 获取一行数据
 * @param id
 * @return {UnwrapNestedRefs<{}>}
 */
export const useYishengFindById = (id) => {
    var form = reactive({});

    canYishengFindById(id).then((res) => {
        extend(form, res);
    });
    return form;
};

/**
 * 根据数据,插入到数据库中
 * @param data
 * @return {Promise<unknown>}
 */
export const canYishengInsert = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/yisheng/insert", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("yisheng_insert", res.data);
                        event.emit("yisheng_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};

/**
 * 根据数据更新数据库
 * @param data
 * @return {Promise<unknown>}
 */
export const canYishengUpdate = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/yisheng/update", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("yisheng_update", res.data);
                        event.emit("yisheng_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};

/**
 * 根据id 或者列表id
 * @param id
 * @return {Promise<unknown>}
 */
export const canYishengDelete = (id) => {
    var res = [];
    if (!isArray(id)) {
        res.push(id);
    } else {
        res = id;
    }

    return new Promise((resolve, reject) => {
        http.post("/api/yisheng/delete", res)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("yisheng_delete", res.data);
                        event.emit("yisheng_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};
