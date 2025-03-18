import http from "@/utils/ajax/http";
import { useRoute } from "vue-router";
import { useUserStore } from "@/stores";
import { reactive, ref, unref } from "vue";
import rule from "@/utils/rule";
import { extend, isArray } from "@/utils/extend";
import { ElMessageBox } from "element-plus";
import router from "@/router";
import event from "@/utils/event";

import { canPaibanFindById } from "./paiban";

/**
 * 响应式的对象数据
 */

export const YuyueguahaoCreateForm = () => {
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
        shijianyuyue: rule.date("Y-m-d H:i:s"),
        huanzhexingming: $session.xingming,
        nianling: $session.nianling,
        shouji: $session.shouji,
        beizhu: "",
        guahaoren: $session.username,
        zhuangtai: "已挂号",
    };

    return form;
};

function exportForm(form, readMap) {
    var autoText = ["paibanid", "yishengid", "zhanghao", "xingming", "zhicheng"];
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
export const canYuyueguahaoCreateForm = (id, readMap) => {
    return new Promise(async (resolve, reject) => {
        var form = YuyueguahaoCreateForm();
        if (!readMap || !readMap.id) {
            readMap = await canPaibanFindById(id).catch(reject);
        }
        exportForm(form, readMap);
        form.paibanid = readMap.id;
        resolve({ form, readMap });
    });
};

/**
 * 响应式获取预约挂号 模块的表单字段数据
 * @return {UnwrapNestedRefs<{}>}
 */
export const useYuyueguahaoCreateForm = (id) => {
    const form = YuyueguahaoCreateForm();
    const formReactive = reactive(form);

    const readMap = reactive({});
    canPaibanFindById(id).then(
        (map) => {
            exportForm(formReactive, map);
            extend(readMap, map);
            formReactive.paibanid = map.id;
        },
        (err) => {
            ElMessageBox.alert(err.message);
        }
    );
    return { form: formReactive, readMap };
};

export const canYuyueguahaoSelect = (filter, result) => {
    http.post("/api/yuyueguahao/selectPages").then((res) => {
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
export const useYuyueguahaoSelect = (filter) => {
    const result = reactive({
        lists: [],
        total: {},
    });
    canYuyueguahaoSelect(filter, result);
    return result;
};

/**
 * 根据
 * @param id
 * @return {Promise|form}
 */
export const canYuyueguahaoFindById = (id) => {
    return new Promise((resolve, reject) => {
        // 读取后台数据
        http.get("/api/yuyueguahao/findById", { id }).then((res) => {
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
export const useYuyueguahaoFindById = (id) => {
    var form = reactive({});

    canYuyueguahaoFindById(id).then((res) => {
        extend(form, res);
    });
    return form;
};

/**
 * 根据数据,插入到数据库中
 * @param data
 * @return {Promise<unknown>}
 */
export const canYuyueguahaoInsert = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/yuyueguahao/insert", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("yuyueguahao_insert", res.data);
                        event.emit("yuyueguahao_change", res.data);
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
export const canYuyueguahaoUpdate = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/yuyueguahao/update", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("yuyueguahao_update", res.data);
                        event.emit("yuyueguahao_change", res.data);
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
export const canYuyueguahaoDelete = (id) => {
    var res = [];
    if (!isArray(id)) {
        res.push(id);
    } else {
        res = id;
    }

    return new Promise((resolve, reject) => {
        http.post("/api/yuyueguahao/delete", res)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("yuyueguahao_delete", res.data);
                        event.emit("yuyueguahao_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};
