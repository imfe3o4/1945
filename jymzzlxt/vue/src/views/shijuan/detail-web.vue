<template>
    <div class="views-shijuan-web-detail">
        <div>
            <e-container>
                <div class="title-sn-title1">
                    <div class="sn-title">
                        <span> 详情 </span>
                    </div>
                    <div class="sn-content">
                        <div style="text-indent: 1em">{{ map.shijuanjianjie }}</div>
                    </div>
                </div>

                <div style="">
                    <e-paper-form
                        @submit="postPaper"
                        :ks-time="map.shichang"
                        :list="shitiList"
                        timu="shititimu"
                        daan="daan"
                        type="leixing"
                        danxuanti="单选题,判断题"
                        duoxuanti="多选题"
                    >
                    </e-paper-form>
                </div>
            </e-container>
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";
    import router from "@/router";
    import rule from "@/utils/rule";
    import date from "@/utils/date";

    import { ref, reactive, watch, computed } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { extend } from "@/utils/extend";
    import { useShijuanFindById, canShijuanFindById, canJieguoInsert, canChengjiInsert } from "@/module";
    import { ElLoading, ElMessageBox, ElMessage } from "element-plus";

    const route = useRoute();
    const props = defineProps({
        id: {
            type: [Number, String],
        },
        isShowBtn: {
            type: Boolean,
            default: true,
        },
    });

    // 获取详情页面的一行数据,当url参数id变更时，自动
    const map = useShijuanFindById(props.id);
    // 当url参数id变更时，自动更新map中的数据
    watch(
        () => props.id,
        (id) => {
            canShijuanFindById(id).then((res) => {
                extend(map, res);
            });
        }
    );
    // end 获取详情页面的一行数据

    const shitiList = ref([]);

    const loadShiti = async () => {
        var tmpShiti = [];
        var id = route.query.id;
        tmpShiti = tmpShiti.concat.apply(tmpShiti, await DB.name("shiti").where("shijuanid", id).where("leixing", "单选题").limit("100").order("rand()").select());
        tmpShiti = tmpShiti.concat.apply(tmpShiti, await DB.name("shiti").where("shijuanid", id).where("leixing", "多选题").limit("100").order("rand()").select());
        tmpShiti = tmpShiti.concat.apply(tmpShiti, await DB.name("shiti").where("shijuanid", id).where("leixing", "判断题").limit("100").order("rand()").select());

        shitiList.value = tmpShiti;
    };
    watch(() => route.query.id, loadShiti, { immediate: true });

    const loading = ref(false);
    function postPaper(paperList, time) {
        if (loading.value) return;
        loading.value = true;
        var leixingdefen = {};
        var zongdefen = 0;
        var promiseList = [];
        var data = {
            kaoshibianhao: rule.getID(),
            datiren: session("username"),
            addtime: date("Y-m-d H:i:s"),
        };

        var ci;
        for (var i in paperList) {
            ci = paperList[i];
            if (!ci.daan) {
                loading.value = false;
                var el = document.querySelector("#paper" + i);
                window.scrollTo(0, el.offsetTop);

                ElMessageBox.alert(`请认真做题，【第${Math.floor(i) + 1}题、${ci.cepingtimu}】，未选择`);
                return;
            }
        }

        const loadingInstance = ElLoading.service({
            fullscreen: true,
            lock: true,
            text: "加载中...",
        });

        for (var ci of paperList) {
            ci.defen = parseFloat(ci.defen);
            if (!leixingdefen[ci.leixing]) {
                leixingdefen[ci.leixing] = 0;
            }
            if (ci.defen > 0) {
                leixingdefen[ci.leixing] += ci.defen;
                zongdefen += ci.defen;
            }

            var obj = extend(true, {}, map, data, ci);
            obj.shiti = obj.shitiid = ci.id;

            delete obj.id;
            promiseList.push(canJieguoInsert(obj));
        }

        Promise.all(promiseList)
            .then(async (res) => {
                var postData = {
                    yongshi: time,
                    zongdefen: zongdefen,
                };

                var obj = extend(true, {}, map, data, postData);
                obj.shijuanid = obj.id;
                delete obj.id;

                var r = await canChengjiInsert(obj);
                loadingInstance.close();
                if (r.code === 0) {
                    ElMessageBox.alert("答题完成");
                    router.replace("/");
                }
            })
            .catch((err) => {
                loadingInstance.close();
            });
    }
</script>

<style scoped lang="scss">
    .views-shijuan-web-detail {
    }
</style>
