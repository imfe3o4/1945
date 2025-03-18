<template>
    <div class="views-yisheng-web-detail">
        <div>
            <e-container>
                <div class="title-sn-title1">
                    <div class="sn-title">
                        <span> 医生详情 </span>
                    </div>
                    <div class="sn-content">
                        <div class="">
                            <div class="goods-info clearfix">
                                <div class="gallery-list">
                                    <e-shangpinban :images="map.zhaopian"></e-shangpinban>
                                </div>
                                <div class="goods-right-content">
                                    <h3 class="title" v-text="map.xingming"></h3>
                                    <div class="descount">
                                        <div>
                                            <span class="name"> 账号： </span>
                                            <span class="val"> {{ map.zhanghao }} </span>
                                        </div>
                                        <div>
                                            <span class="name"> 职称： </span>
                                            <span class="val"> {{ map.zhicheng }} </span>
                                        </div>
                                        <div>
                                            <span class="name"> 手机： </span>
                                            <span class="val"> {{ map.shouji }} </span>
                                        </div>
                                    </div>
                                    <el-button type="primary" @click="$router.push('/liuyanban/add?id='+map.id)">留言</el-button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </e-container>
        </div>
        <div>
            <e-container>
                <e-container>
                    <el-tabs type="border-card">
                        <el-tab-pane label="医生简介">
                            <div style="text-indent: 2em">
                                <div v-html="map.jianjie"></div>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="医生排班">
                            <div class="list-table">
                                <table width="100%" border="1" class="table table-list table-bordered table-hover">
                                    <thead>
                                        <tr align="center">
                                            <th>账号</th>
                                            <th>姓名</th>
                                            <th>职称</th>
                                            <th>上班时间</th>
                                            <th>下班时间</th>

                                            <th width="80" align="center">操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(r,i) in paibanlist">
                                            <td>{{ r.zhanghao }}</td>
                                            <td>{{ r.xingming }}</td>
                                            <td>{{ r.zhicheng }}</td>
                                            <td>{{ r.shangbanshijian }}</td>
                                            <td>{{ r.xiabanshijian }}</td>
                                            <td align="center">
                                                <el-button type="primary" @click="$router.push('/yuyueguahao/add?id='+r.id)">预约挂号</el-button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </el-tab-pane>
                    </el-tabs>
                </e-container>
            </e-container>
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";
    import EShangpinban from "@/components/shangpin/shangpinban.vue";

    import { ref, reactive, watch, computed } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { extend } from "@/utils/extend";
    import { useYishengFindById, canYishengFindById } from "@/module";

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
    const map = useYishengFindById(props.id);
    // 当url参数id变更时，自动更新map中的数据
    watch(
        () => props.id,
        (id) => {
            canYishengFindById(id).then((res) => {
                extend(map, res);
            });
        }
    );
    // end 获取详情页面的一行数据

    // 定义响应式变量paibanlist
    const paibanlist = ref([]);
    const getpaibanlist = async () => {
        // 获取排班数据,并赋值给paibanlist变量
        paibanlist.value = await DB.name("paiban").where("zhanghao", map.zhanghao).limit("100").order("id desc").select();
    };
    // 监听map值变化后，并重新获取数据排班模块的数据
    watch(() => map, getpaibanlist, { immediate: true, deep: true });
</script>

<style scoped lang="scss">
    .views-yisheng-web-detail {
    }
</style>
