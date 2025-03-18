<template>
    <div class="views-wenzhang-web-detail">
        <div>
            <e-container>
                <div class="title-modelbox-widget1">
                    <h3 class="section-title">文章详情</h3>
                    <div class="sidebar-widget-body">
                        <div>
                            <div class="common-title" style="margin-top: 4em">
                                <p>
                                    <i></i>
                                    <i></i>
                                </p>
                            </div>
                            <div class="news_show">
                                <div style="float: right"></div>

                                <div class="show_t" v-html="map.biaoti"></div>

                                <div class="fa_time">点击量:{{ map.dianjiliang }} &nbsp;&nbsp; 添加人:{{ map.tianjiaren }} &nbsp;&nbsp;</div>

                                <div v-html="map.xiangqing"></div>
                                <div class="s_x clearfix">
                                    <template v-if="prev?.id">
                                        <router-link :to="'/wenzhang/detail?id='+prev.id" class="s_prev"> 上一篇：<span v-html="prev.biaoti"></span> </router-link>
                                    </template>
                                    <template v-else>
                                        <a href="javascript:;" class="s_prev">上一篇：没有了</a>
                                    </template>
                                    <template v-if="next?.id">
                                        <router-link :to="'/wenzhang/detail?id='+next.id" class="x_next"> 下一篇：<span v-html="next.biaoti"></span> </router-link>
                                    </template>
                                    <template v-else>
                                        <a href="javascript:;" class="x_next">下一篇：没有了</a>
                                    </template>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.sidebar-widget-body -->
                </div>
            </e-container>
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";

    import { ref, reactive, watch, computed } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { extend } from "@/utils/extend";
    import { useWenzhangFindById, canWenzhangFindById } from "@/module";

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
    const loadWebFind = (id) => {
        http.post("/api/wenzhang/detailWeb", { id }).then((res) => {
            console.log(res.data);
        });
    };
    watch(() => props.id, loadWebFind, { immediate: true });
    // 获取详情页面的一行数据,当url参数id变更时，自动
    const map = useWenzhangFindById(props.id);
    // 当url参数id变更时，自动更新map中的数据
    watch(
        () => props.id,
        (id) => {
            canWenzhangFindById(id).then((res) => {
                extend(map, res);
            });
        }
    );
    // end 获取详情页面的一行数据

    const prev = ref({});
    const next = ref({});
    watch(
        () => route.query.id,
        async (id) => {
            prev.value = await DB.name("wenzhang").where("id", "<", id).order("id desc").find();
            next.value = await DB.name("wenzhang").where("id", ">", id).order("id asc").find();
        },
        { immediate: true }
    );
</script>

<style scoped lang="scss">
    .views-wenzhang-web-detail {
    }
</style>
