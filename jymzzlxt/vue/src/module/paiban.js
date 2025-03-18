import http from "@/utils/ajax/http";
import { useRoute } from "vue-router";
import { useUserStore } from "@/stores";
import { reactive, ref, unref } from "vue";
import rule from "@/utils/rule";
import { extend, isArray } from "@/utils/extend";
import { ElMessageBox } from "element-plus";
import router from "@/router";
import event from "@/utils/event";

import { canYishengFindById } from "./yisheng";

/**
 * 响应式的对象数据
 */

export const PaibanCreateForm = () => {
    var route = unref(router.currentRoute);
    const userStore = useUserStore();
    const $session = userStore.session;
    if (!route.query) {
        route = useRoute();
    }
    const form = {
        zhanghao: $session.username,
        xingming: "",
        zhicheng: "",
        shangbanshijian: "",
        xiabanshijian: "",
    };

    return form;
};

function exportForm(form, readMap) {
    var autoText = ["yishengid", "zhanghao", "xingming", "zhicheng"];
    for (var txt of autoText) {
        form[txt] = readMap[txt];
    }
}

/**
 * 异步模式获取数据
 * @param id
 * @param readMap
 * @return {Promise}
 */
export const canPaibanCreateForm = (id, readMap) => {
    return new Promise(async (resolve, reject) => {
        var form = PaibanCreateForm();
        if (!readMap || !readMap.id) {
            readMap = await canYishengFindById(id).catch(reject);
        }
        exportForm(form, readMap);
        form.yishengid = readMap.id;
        resolve({ form, readMap });
    });
};

/**
 * 响应式获取排班 模块的表单字段数据
 * @return {UnwrapNestedRefs<{}>}
 */
export const usePaibanCreateForm = (id) => {
    const form = PaibanCreateForm();
    const formReactive = reactive(form);

    const readMap = reactive({});
    canYishengFindById(id).then(
        (map) => {
            exportForm(formReactive, map);
            extend(readMap, map);
            formReactive.yishengid = map.id;
        },
        (err) => {
            ElMessageBox.alert(err.message);
        }
    );
    return { form: formReactive, readMap };
};

export const canPaibanSelect = (filter, result) => {
    http.post("/api/paiban/selectPages").then((res) => {
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
export const usePaibanSelect = (filter) => {
    const result = reactive({
        lists: [],
        total: {},
    });
    canPaibanSelect(filter, result);
    return result;
};

/**
 * 根据
 * @param id
 * @return {Promise|form}
 */
export const canPaibanFindById = (id) => {
    return new Promise((resolve, reject) => {
        // 读取后台数据
        http.get("/api/paiban/findById", { id }).then((res) => {
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
export const usePaibanFindById = (id) => {
    var form = reactive({});

    canPaibanFindById(id).then((res) => {
        extend(form, res);
    });
    return form;
};

/**
 * 根据数据,插入到数据库中
 * @param data
 * @return {Promise<unknown>}
 */
export const canPaibanInsert = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/paiban/insert", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("paiban_insert", res.data);
                        event.emit("paiban_change", res.data);
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
export const canPaibanUpdate = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/paiban/update", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("paiban_update", res.data);
                        event.emit("paiban_change", res.data);
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
export const canPaibanDelete = (id) => {
    var res = [];
    if (!isArray(id)) {
        res.push(id);
    } else {
        res = id;
    }

    return new Promise((resolve, reject) => {
        http.post("/api/paiban/delete", res)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("paiban_delete", res.data);
                        event.emit("paiban_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};
