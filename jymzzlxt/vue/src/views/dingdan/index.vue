<template>
    <div class="views-dingdan-index">
        <div>
            <e-container>
                <div class="title-sn-title-shinei">
                    <div class="sn-title">
                        <span> 订单 </span>
                    </div>
                    <div class="sn-content">
                        <div class="list-table">
                            <table width="100%" border="1" class="table table-list table-bordered table-hover">
                                <thead>
                                    <tr align="center">
                                        <th>订单号</th>
                                        <th>订单金额</th>
                                        <th>收货人</th>
                                        <th>手机</th>
                                        <th>地址</th>
                                        <th>备注</th>
                                        <th>状态</th>
                                        <th>下单人</th>
                                        <th>添加时间</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="(r,i) in lists">
                                        <td>{{ r.dingdanhao }}</td>
                                        <td>{{ r.dingdanjine }}</td>
                                        <td>{{ r.shouhuoren }}</td>
                                        <td>{{ r.shouji }}</td>
                                        <td>{{ r.dizhi }}</td>
                                        <td>{{ r.shouhuoren }}</td>
                                        <td>{{ r.shouji }}</td>
                                        <td>{{ r.dizhi }}</td>
                                        <td>{{ r.beizhu }}</td>
                                        <td>{{ r.zhuangtai }}</td>
                                        <td>{{ r.xiadanren }}</td>
                                        <td>{{ r.addtime.substring(0,19) }}</td>
                                    </tr>
                                </tbody>
                            </table>
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
    import { canDingdanSelect, useDingdanSelect, canDingdanDelete } from "@/module";
    import { extend } from "@/utils/extend";
    import { ElMessageBox, ElMessage } from "element-plus";

    const route = useRoute();
    const search = reactive({
        dingdanhao: "",
        shangpin: "",
        shouhuoren: "",
        zhuangtai: "",
        page: 1, // 当前页
        pagesize: 12, // 每页行数
        orderby: "id", // 排序字段
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

    // 加载订单列表方法
    const loadList = (page) => {
        // 加载
        if (unref(loading)) return;
        loading.value = true;
        search.page = page;

        http.post("/api/dingdan/selectPages", search).then(
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
    .views-dingdan-index {
    }
</style>
