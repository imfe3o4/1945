<template>
    <div class="views-yaopin-web-detail">
        <div>
            <e-container>
                <div class="title-sn-title1">
                    <div class="sn-title">
                        <span> 详情 </span>
                    </div>
                    <div class="sn-content">
                        <div class="">
                            <div class="goods-info clearfix">
                                <div class="gallery-list">
                                    <e-shangpinban :images="map.tupian"></e-shangpinban>
                                </div>
                                <div class="goods-right-content">
                                    <h3 class="title" v-text="map.mingcheng"></h3>
                                    <div class="descount">
                                        <div>
                                            <span class="name"> 编号： </span>
                                            <span class="val"> {{ map.bianhao }} </span>
                                        </div>
                                        <div>
                                            <span class="name"> 分类： </span>
                                            <span class="val"> <e-select-view module="leibie" :value="map.fenlei" select="id" show="leibiemingcheng"></e-select-view> </span>
                                        </div>
                                        <div>
                                            <span class="name"> 价格： </span>
                                            <span class="val"> {{ map.jiage }} </span>
                                        </div>
                                        <div>
                                            <span class="name"> 库存： </span>
                                            <span class="val"> {{ map.kucun }} </span>
                                        </div>
                                        <div>
                                            <span class="name"> 销量： </span>
                                            <span class="val"> {{ map.xiaoliang }} </span>
                                        </div>
                                    </div>

                                    <el-form :model="gouwucheForm" ref="gouwucheFormElement" v-show="$session.username">
                                        <el-form-item
                                            label="购买数"
                                            prop="goumaishu"
                                            required
                                            :rules="[{required:true, message:'请填写购买数'}, {validator:rule.checkNumber, message:'输入一个有效数字'}, {validator:rule.checkMin, value:1}, {validator:rule.checkMax, value:readMap.kucun}]"
                                        >
                                            <el-input-number v-model="gouwucheForm.goumaishu" :min="1" step="1"></el-input-number>
                                        </el-form-item>
                                    </el-form>

                                    <el-button type="primary" @click="onAddCard">加入购物车</el-button>
                                    <el-button type="primary" @click="onAddOrder">立即购买</el-button>
                                </div>
                            </div>
                            <div class="goods-content" v-html="map.yaopinxiangqing"></div>
                        </div>
                    </div>
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
    import EShangpinban from "@/components/shangpin/shangpinban.vue";

    import { ref, reactive, watch, computed, unref } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { extend } from "@/utils/extend";
    import { useYaopinFindById, canYaopinFindById, canGouwucheCreateForm, canGouwucheInsert } from "@/module";
    import { ElLoading, ElMessage, ElMessageBox } from "element-plus";

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
    const map = useYaopinFindById(props.id);
    // 当url参数id变更时，自动更新map中的数据
    watch(
        () => props.id,
        (id) => {
            canYaopinFindById(id).then((res) => {
                extend(map, res);
            });
        }
    );
    // end 获取详情页面的一行数据

    const gouwucheForm = ref({});
    const readMap = ref({});
    const gouwucheFormElement = ref(null);

    watch(
        () => map,
        async () => {
            if (!map.id || !session("username")) return;

            var s = await canGouwucheCreateForm(map.id, map);
            gouwucheForm.value = s.form;
            readMap.value = s.readMap;
        },
        { deep: true }
    );

    const onAddCard = async () => {
        if (!session("username")) {
            var r = await ElMessageBox.confirm("请先登录");
            router.push({ path: "/login", query: { redirect: route.fullPath } });
            return;
        }
        gouwucheFormElement.value.validate().then(async () => {
            const loadingInstance = ElLoading.service({
                fullscreen: true,
                lock: true,
                text: "正在提交...",
            });
            try {
                const res = await canGouwucheInsert(gouwucheForm.value);
                loadingInstance.close();
                if (res.code == 0) {
                    ElMessage.success("添加购物车成功");
                } else {
                    ElMessage.error(res.msg);
                }
            } catch (e) {
                ElMessage.error(e.message);
                loadingInstance.close();
            }
        });
    };
    const onAddOrder = async () => {
        if (!session("username")) {
            var r = await ElMessageBox.confirm("请先登录");
            router.push({ path: "/login", query: { redirect: route.fullPath } });
            return;
        }
        gouwucheFormElement.value.validate().then(async () => {
            var data = unref(gouwucheForm);
            var sum_xiaoji = (data.xiaoji = data.goumaishu * data.jiage);
            var url = "/dingdan/add";

            sessionStorage.setItem("JSON", JSON.stringify([data]));
            router.push({
                path: url,
                query: {
                    sum_xiaoji: sum_xiaoji,
                    liji: 1,
                    ids: 0,
                },
            });
        });
    };
</script>

<style scoped lang="scss">
    .views-yaopin-web-detail {
    }
</style>
