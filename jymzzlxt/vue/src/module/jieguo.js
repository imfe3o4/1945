import http from "@/utils/ajax/http";
import { useRoute } from "vue-router";
import { useUserStore } from "@/stores";
import { reactive, ref, unref } from "vue";
import rule from "@/utils/rule";
import { extend, isArray } from "@/utils/extend";
import { ElMessageBox } from "element-plus";
import router from "@/router";
import event from "@/utils/event";

import { canShijuanFindById } from "./shijuan";

/**
 * 响应式的对象数据
 */

export const JieguoCreateForm = () => {
    var route = unref(router.currentRoute);
    const userStore = useUserStore();
    const $session = userStore.session;
    if (!route.query) {
        route = useRoute();
    }
    const form = {
        shijuanbianhao: "",
        shijuanmingcheng: "",
        faburen: $session.username,
        datileixing: "",
        kaoshibianhao: rule.getID(),
        shititimu: "",
        leixing: "",
        daan: "",
        defen: "",
        datiren: $session.username,
    };

    return form;
};

function exportForm(form, readMap) {
    var autoText = ["shijuanid", "shijuanbianhao", "shijuanmingcheng", "faburen", "datileixing"];
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
export const canJieguoCreateForm = (id, readMap) => {
    return new Promise(async (resolve, reject) => {
        var form = JieguoCreateForm();
        if (!readMap || !readMap.id) {
            readMap = await canShijuanFindById(id).catch(reject);
        }
        exportForm(form, readMap);
        form.shijuanid = readMap.id;
        resolve({ form, readMap });
    });
};

/**
 * 响应式获取结果 模块的表单字段数据
 * @return {UnwrapNestedRefs<{}>}
 */
export const useJieguoCreateForm = (id) => {
    const form = JieguoCreateForm();
    const formReactive = reactive(form);

    const readMap = reactive({});
    canShijuanFindById(id).then(
        (map) => {
            exportForm(formReactive, map);
            extend(readMap, map);
            formReactive.shijuanid = map.id;
        },
        (err) => {
            ElMessageBox.alert(err.message);
        }
    );
    return { form: formReactive, readMap };
};

export const canJieguoSelect = (filter, result) => {
    http.post("/api/jieguo/selectPages").then((res) => {
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
export const useJieguoSelect = (filter) => {
    const result = reactive({
        lists: [],
        total: {},
    });
    canJieguoSelect(filter, result);
    return result;
};

/**
 * 根据
 * @param id
 * @return {Promise|form}
 */
export const canJieguoFindById = (id) => {
    return new Promise((resolve, reject) => {
        // 读取后台数据
        http.get("/api/jieguo/findById", { id }).then((res) => {
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
export const useJieguoFindById = (id) => {
    var form = reactive({});

    canJieguoFindById(id).then((res) => {
        extend(form, res);
    });
    return form;
};

/**
 * 根据数据,插入到数据库中
 * @param data
 * @return {Promise<unknown>}
 */
export const canJieguoInsert = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/jieguo/insert", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("jieguo_insert", res.data);
                        event.emit("jieguo_change", res.data);
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
export const canJieguoUpdate = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/jieguo/update", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("jieguo_update", res.data);
                        event.emit("jieguo_change", res.data);
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
export const canJieguoDelete = (id) => {
    var res = [];
    if (!isArray(id)) {
        res.push(id);
    } else {
        res = id;
    }

    return new Promise((resolve, reject) => {
        http.post("/api/jieguo/delete", res)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("jieguo_delete", res.data);
                        event.emit("jieguo_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};
