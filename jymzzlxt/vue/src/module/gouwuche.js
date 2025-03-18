import http from "@/utils/ajax/http";
import { useRoute } from "vue-router";
import { useUserStore } from "@/stores";
import { reactive, ref, unref } from "vue";
import rule from "@/utils/rule";
import { extend, isArray } from "@/utils/extend";
import { ElMessageBox } from "element-plus";
import router from "@/router";
import event from "@/utils/event";

import { canYaopinFindById } from "./yaopin";

/**
 * 响应式的对象数据
 */

export const GouwucheCreateForm = () => {
    var route = unref(router.currentRoute);
    const userStore = useUserStore();
    const $session = userStore.session;
    if (!route.query) {
        route = useRoute();
    }
    const form = {
        bianhao: "",
        mingcheng: "",
        fenlei: "",
        jiage: "",
        tupian: "",
        goumaishu: "",
        goumairen: $session.username,
    };

    return form;
};

function exportForm(form, readMap) {
    var autoText = ["yaopinid", "bianhao", "mingcheng", "fenlei", "jiage", "tupian"];
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
export const canGouwucheCreateForm = (id, readMap) => {
    return new Promise(async (resolve, reject) => {
        var form = GouwucheCreateForm();
        if (!readMap || !readMap.id) {
            readMap = await canYaopinFindById(id).catch(reject);
        }
        exportForm(form, readMap);
        form.yaopinid = readMap.id;
        resolve({ form, readMap });
    });
};

/**
 * 响应式获取购物车 模块的表单字段数据
 * @return {UnwrapNestedRefs<{}>}
 */
export const useGouwucheCreateForm = (id) => {
    const form = GouwucheCreateForm();
    const formReactive = reactive(form);

    const readMap = reactive({});
    canYaopinFindById(id).then(
        (map) => {
            exportForm(formReactive, map);
            extend(readMap, map);
            formReactive.yaopinid = map.id;
        },
        (err) => {
            ElMessageBox.alert(err.message);
        }
    );
    return { form: formReactive, readMap };
};

export const canGouwucheSelect = (filter, result) => {
    http.post("/api/gouwuche/selectPages").then((res) => {
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
export const useGouwucheSelect = (filter) => {
    const result = reactive({
        lists: [],
        total: {},
    });
    canGouwucheSelect(filter, result);
    return result;
};

/**
 * 根据
 * @param id
 * @return {Promise|form}
 */
export const canGouwucheFindById = (id) => {
    return new Promise((resolve, reject) => {
        // 读取后台数据
        http.get("/api/gouwuche/findById", { id }).then((res) => {
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
export const useGouwucheFindById = (id) => {
    var form = reactive({});

    canGouwucheFindById(id).then((res) => {
        extend(form, res);
    });
    return form;
};

/**
 * 根据数据,插入到数据库中
 * @param data
 * @return {Promise<unknown>}
 */
export const canGouwucheInsert = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/gouwuche/insert", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("gouwuche_insert", res.data);
                        event.emit("gouwuche_change", res.data);
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
export const canGouwucheUpdate = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/gouwuche/update", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("gouwuche_update", res.data);
                        event.emit("gouwuche_change", res.data);
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
export const canGouwucheDelete = (id) => {
    var res = [];
    if (!isArray(id)) {
        res.push(id);
    } else {
        res = id;
    }

    return new Promise((resolve, reject) => {
        http.post("/api/gouwuche/delete", res)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("gouwuche_delete", res.data);
                        event.emit("gouwuche_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};
