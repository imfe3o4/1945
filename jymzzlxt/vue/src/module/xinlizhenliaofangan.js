import http from "@/utils/ajax/http";
import { useRoute } from "vue-router";
import { useUserStore } from "@/stores";
import { reactive, ref, unref } from "vue";
import rule from "@/utils/rule";
import { extend, isArray } from "@/utils/extend";
import { ElMessageBox } from "element-plus";
import router from "@/router";
import event from "@/utils/event";

import { canYuyueguahaoFindById } from "./yuyueguahao";

/**
 * 响应式的对象数据
 */

export const XinlizhenliaofanganCreateForm = () => {
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
        huanzhexingming: $session.xingming,
        nianling: $session.nianling,
        guahaoren: $session.username,
        zhenliaofangan: "",
        chufang: "",
    };

    return form;
};

function exportForm(form, readMap) {
    var autoText = ["yuyueguahaoid", "paibanid", "yishengid", "zhanghao", "xingming", "zhicheng", "huanzhexingming", "nianling", "guahaoren"];
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
export const canXinlizhenliaofanganCreateForm = (id, readMap) => {
    return new Promise(async (resolve, reject) => {
        var form = XinlizhenliaofanganCreateForm();
        if (!readMap || !readMap.id) {
            readMap = await canYuyueguahaoFindById(id).catch(reject);
        }
        exportForm(form, readMap);
        form.yuyueguahaoid = readMap.id;
        resolve({ form, readMap });
    });
};

/**
 * 响应式获取心理诊疗方案 模块的表单字段数据
 * @return {UnwrapNestedRefs<{}>}
 */
export const useXinlizhenliaofanganCreateForm = (id) => {
    const form = XinlizhenliaofanganCreateForm();
    const formReactive = reactive(form);

    const readMap = reactive({});
    canYuyueguahaoFindById(id).then(
        (map) => {
            exportForm(formReactive, map);
            extend(readMap, map);
            formReactive.yuyueguahaoid = map.id;
        },
        (err) => {
            ElMessageBox.alert(err.message);
        }
    );
    return { form: formReactive, readMap };
};

export const canXinlizhenliaofanganSelect = (filter, result) => {
    http.post("/api/xinlizhenliaofangan/selectPages").then((res) => {
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
export const useXinlizhenliaofanganSelect = (filter) => {
    const result = reactive({
        lists: [],
        total: {},
    });
    canXinlizhenliaofanganSelect(filter, result);
    return result;
};

/**
 * 根据
 * @param id
 * @return {Promise|form}
 */
export const canXinlizhenliaofanganFindById = (id) => {
    return new Promise((resolve, reject) => {
        // 读取后台数据
        http.get("/api/xinlizhenliaofangan/findById", { id }).then((res) => {
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
export const useXinlizhenliaofanganFindById = (id) => {
    var form = reactive({});

    canXinlizhenliaofanganFindById(id).then((res) => {
        extend(form, res);
    });
    return form;
};

/**
 * 根据数据,插入到数据库中
 * @param data
 * @return {Promise<unknown>}
 */
export const canXinlizhenliaofanganInsert = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/xinlizhenliaofangan/insert", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("xinlizhenliaofangan_insert", res.data);
                        event.emit("xinlizhenliaofangan_change", res.data);
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
export const canXinlizhenliaofanganUpdate = (data) => {
    return new Promise((resolve, reject) => {
        http.post("/api/xinlizhenliaofangan/update", data)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("xinlizhenliaofangan_update", res.data);
                        event.emit("xinlizhenliaofangan_change", res.data);
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
export const canXinlizhenliaofanganDelete = (id) => {
    var res = [];
    if (!isArray(id)) {
        res.push(id);
    } else {
        res = id;
    }

    return new Promise((resolve, reject) => {
        http.post("/api/xinlizhenliaofangan/delete", res)
            .json()
            .then(
                (res) => {
                    resolve(res);
                    if (res.code == 0) {
                        event.emit("xinlizhenliaofangan_delete", res.data);
                        event.emit("xinlizhenliaofangan_change", res.data);
                    }
                },
                (err) => {
                    reject(err);
                }
            );
    });
};
