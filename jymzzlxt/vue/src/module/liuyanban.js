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

export const LiuyanbanCreateForm = () => {
    var route = unref(router.currentRoute);
    const userStore = useUserStore();
    const $session = userStore.session;
    if (!route.query) {
        route = useRoute();
    }
    const form = {
        zhanghao: $session.username,
        xingming: "",
        zixunrenxingming: $session.xingming,
        lianxidianhua: $session.shouji,
        liuyanneirong: "",
        liuyanren: $session.username,
    };

    return form;
};

function exportForm(form, readMap) {
    var autoText = ["yishengid", "zhanghao", "xingming"];
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
export const canLiuyanbanCreateForm = (id, readMap) => {
    return new Promise(async (resolve, reject) => {
        var form = LiuyanbanCreateForm();
        if (!readMap || !readMap.id) {
            readMap = await canYishengFindById(id).catch(reject);
        }
        exportForm(form, readMap);
        form.yishengid = readMap.id;
        resolve({ form, readMap });
    });
};

/**
 * 响应式获取留言板 模块的表单字段数据
 * @return {UnwrapNestedRefs<{}>}
 */
export const useLiuyanbanCreateForm = (id) => {
    const form = LiuyanbanCreateForm();
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

export const canLiuyanbanSelect = (filter, result) => {
    http.post("/api/liuyanban/selectPages").then((res) => {
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
export const useLiuyanbanSelect = (filter) => {
    const result = reactive({
        lists: [],
        total: {},
    });
    canLiuyanbanSelect(filter, result);
    return result;
};

/**
 * 根据
 * @param id
 * @return {Promise|form}
 */
export const canLiuyanbanFindById = (id) => {
    return new Promise((resolve, reject) => {
        // 读取后台数据
        http.get("/api/liuyanban/findById", { id }).then((res) => {
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
export const useLiuyanbanFindById = (id) => {
    var form = reactive({});

    canLiuyanbanFindById(id).then((res) => {
        extend(form, res);
    });
    return form;
};

/**
 * 根据数据,插入到数据库中
 * @param data
 * @return {Promise<unknown>}
 */
export const canLiuyanbanInsert = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/liuyanban/insert", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("liuyanban_insert", res.data);
                        event.emit("liuyanban_change", res.data);
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
export const canLiuyanbanUpdate = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/liuyanban/update", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("liuyanban_update", res.data);
                        event.emit("liuyanban_change", res.data);
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
export const canLiuyanbanDelete = (id) => {
    var res = [];
    if (!isArray(id)) {
        res.push(id);
    } else {
        res = id;
    }

    return new Promise((resolve, reject) => {
        http.post("/api/liuyanban/delete", res)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("liuyanban_delete", res.data);
                        event.emit("liuyanban_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};
