<template>
    <div class="views-yonghu-index">
        <div>
            <e-container>
                <div class="title-sn-title1">
                    <div class="sn-title">
                        <span> 积分排行 </span>
                    </div>
                    <div class="sn-content">
                        <div class="">
                            <div class="e-news-info clearfix" v-for="r in lists" :key="r.id">
                                <div class="thumb" v-if="r.touxiang" @click="$goto('/yonghu/detail?id='+r.id)">
                                    <e-img :src="r.touxiang" pb="100" />
                                </div>
                                <div class="news-content-text" :class="{'not-thumb':!r.touxiang}">
                                    <h2 @click="$goto('/yonghu/detail?id='+r.id)">{{ r.xingming }}</h2>

                                    <div class="other-content">
                                        <span style="font-size: 15px">性别:{{ r.xingbie }}</span>
                                        <span style="font-size: 15px">积分:{{ r.jifen }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div style="margin-top: 10px; text-align: center">
                            <el-pagination
                                @current-change="loadList"
                                :page-sizes="[12, 24, 36, 48,60]"
                                v-model:current-page="search.page"
                                v-model:page-size="search.pagesize"
                                @size-change="sizeChange"
                                layout="total, sizes, prev, pager, next"
                                :total="totalCount"
                            >
                            </el-pagination>
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

    import { ref, reactive, watch, unref, onBeforeMount } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { canYonghuSelect, useYonghuSelect, canYonghuDelete } from "@/module";
    import { extend } from "@/utils/extend";
    import { ElMessageBox, ElMessage } from "element-plus";

    const route = useRoute();
    const search = reactive({
        zhanghao: "",
        page: 1, // 当前页
        pagesize: 12, // 每页行数
        orderby: "jifen", // 排序字段
        sort: "desc", // 排序类型
    });
    extend(search, route.query);
    // 链接参数变化时更新这些内容
    watch(
        () => route.query,
        () => {
            extend(search, route.query);
            loadList(1);
        },
        { deep: true }
    );

    // 总行数
    const totalCount = ref(0);
    // 列表数据
    const lists = ref([]);
    // 加载状态
    const loading = ref(false);

    // 排序操作
    const sortChange = (e) => {
        console.log(e);
        if (e.order == null) {
            search.orderby = "id";
            search.sort = "desc";
        } else {
            search.orderby = e.prop;
            search.sort = e.order == "ascending" ? "asc" : "desc";
        }
        loadList(1);
    };
    // 设置页数多少
    const sizeChange = (e) => {
        search.pagesize = e;
        loadList(1);
    };

    // 加载用户列表方法
    const loadList = (page) => {
        // 加载
        if (unref(loading)) return;
        loading.value = true;
        search.page = page;

        http.post("/api/yonghu/selectPages", search).then(
            (res) => {
                loading.value = false;
                if (res.code == 0) {
                    var data = res.data;
                    lists.value = data.lists.records;
                    totalCount.value = data.lists.total;
                }
            },
            (err) => {
                loading.value = false;
                ElMessage.error(err.message);
            }
        );
    };

    onBeforeMount(() => {
        loadList(1);
    });
</script>

<style scoped lang="scss">
    .views-yonghu-index {
    }
</style>
