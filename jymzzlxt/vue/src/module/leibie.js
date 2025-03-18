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

export const LeibieCreateForm = () => {
    var route = unref(router.currentRoute);
    const userStore = useUserStore();
    const $session = userStore.session;
    if (!route.query) {
        route = useRoute();
    }
    const form = {
        leibiemingcheng: "",
    };

    return form;
};

/**
 * 异步模式获取数据
 * @param id
 * @param readMap
 * @return {Promise}
 */
export const canLeibieCreateForm = () => {
    return new Promise(async (resolve, reject) => {
        var form = LeibieCreateForm();
        resolve({ form });
    });
};

/**
 * 响应式获取类别 模块的表单字段数据
 * @return {UnwrapNestedRefs<{}>}
 */
export const useLeibieCreateForm = () => {
    const form = LeibieCreateForm();
    const formReactive = reactive(form);

    return { form: formReactive };
};

export const canLeibieSelect = (filter, result) => {
    http.post("/api/leibie/selectPages").then((res) => {
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
export const useLeibieSelect = (filter) => {
    const result = reactive({
        lists: [],
        total: {},
    });
    canLeibieSelect(filter, result);
    return result;
};

/**
 * 根据
 * @param id
 * @return {Promise|form}
 */
export const canLeibieFindById = (id) => {
    return new Promise((resolve, reject) => {
        // 读取后台数据
        http.get("/api/leibie/findById", { id }).then((res) => {
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
export const useLeibieFindById = (id) => {
    var form = reactive({});

    canLeibieFindById(id).then((res) => {
        extend(form, res);
    });
    return form;
};

/**
 * 根据数据,插入到数据库中
 * @param data
 * @return {Promise<unknown>}
 */
export const canLeibieInsert = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/leibie/insert", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("leibie_insert", res.data);
                        event.emit("leibie_change", res.data);
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
export const canLeibieUpdate = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/leibie/update", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("leibie_update", res.data);
                        event.emit("leibie_change", res.data);
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
export const canLeibieDelete = (id) => {
    var res = [];
    if (!isArray(id)) {
        res.push(id);
    } else {
        res = id;
    }

    return new Promise((resolve, reject) => {
        http.post("/api/leibie/delete", res)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("leibie_delete", res.data);
                        event.emit("leibie_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};
