<template>
    <div class="views-gouwuche-list">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 购物车查询 </span>
                    </div>
                </template>

                <div class="form-search">
                    <el-form @submit.prevent.stop :inline="true" size="small">
                        <el-form-item label="编号">
                            <el-input v-model="search.bianhao"></el-input>
                        </el-form-item>
                        <el-form-item label="名称">
                            <el-input v-model="search.mingcheng"></el-input>
                        </el-form-item>
                        <el-form-item label="分类">
                            <el-select v-model="search.fenlei"
                                ><el-option label="请选择" value=""></el-option><e-select-option type="option" module="leibie" value="id" label="leibiemingcheng"></e-select-option
                            ></el-select>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="searchSubmit" icon="el-icon-search">查询</el-button>
                        </el-form-item>
                    </el-form>
                </div>

                <el-table border :data="lists" style="width: 100%" @sort-change="sortChange" highlight-current-row @selection-change="handleSelectionChange">
                    <el-table-column type="selection" width="55"> </el-table-column
                    ><!-- 批量选择 -->

                    <el-table-column prop="bianhao" label="编号" width="130">
                        <template #default="{row}"> {{ row.bianhao }} </template>
                    </el-table-column>
                    <el-table-column prop="mingcheng" label="名称">
                        <template #default="{row}"> {{ row.mingcheng }} </template>
                    </el-table-column>
                    <el-table-column prop="fenlei" label="分类" width="80">
                        <template #default="{row}"> <e-select-view module="leibie" :value="row.fenlei" select="id" show="leibiemingcheng"></e-select-view> </template>
                    </el-table-column>
                    <el-table-column sortable="custom" prop="jiage" label="价格" width="80">
                        <template #default="{row}"> {{ row.jiage }} </template>
                    </el-table-column>
                    <el-table-column prop="tupian" label="图片" width="100">
                        <template #default="{row}">
                            <div style="width: 100%; max-width: 120px">
                                <e-img :src="row.tupian" type="list"></e-img>
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column prop="goumaishu" label="购买数" width="80">
                        <template #default="{row}"> {{ row.goumaishu }} </template>
                    </el-table-column>
                    <el-table-column sortable="custom" prop="xiaoji" label="小计" width="80">
                        <template #default="{row}"> {{ row.xiaoji }} </template>
                    </el-table-column>
                    <el-table-column prop="goumairen" label="购买人" width="180">
                        <template #default="{row}"> {{ row.goumairen }} </template>
                    </el-table-column>
                    <el-table-column prop="addtime" label="添加时间">
                        <template #default="{row}"> {{ row.addtime.substring(0,19) }} </template>
                    </el-table-column>

                    <el-table-column label="操作" fixed="right" width="180">
                        <template #default="{row}">
                            <el-button-group>
                                <el-tooltip effect="dark" content="编辑" placement="top-start"
                                    ><el-button type="success" :icon="Edit" size="small" @click="$router.push('/admin/gouwuche/updt?id='+row.id)">编辑</el-button>
                                </el-tooltip>
                                <el-tooltip effect="dark" content="删除" placement="top-start"
                                    ><el-button type="danger" :icon="Delete" size="small" @click="deleteItems(row.id)">删除</el-button>
                                </el-tooltip>
                            </el-button-group>
                        </template>
                    </el-table-column>
                </el-table>
                <div style="margin-top: 10px">
                    订单金额：<span style="color: #990000; font-size: 18px" id="sum_price">￥{{ orderPrice }}</span> 　　
                    <el-button type="danger" @click="createOrder" :disabled="multipleSelection.length==0" button-type="button">生成订单</el-button>
                </div>
                <div class="e-pages" style="margin-top: 10px; text-align: center">
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
            </el-card>
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";
    import router from "@/router";

    import { ref, reactive, watch, unref, onBeforeMount, computed } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { canGouwucheSelect, useGouwucheSelect, canGouwucheDelete } from "@/module";
    import { extend } from "@/utils/extend";
    import { ElMessageBox, ElMessage } from "element-plus";
    import { Edit, Delete } from "@element-plus/icons-vue";

    const route = useRoute();
    const search = reactive({
        yaopinid: "",
        bianhao: "",
        mingcheng: "",
        fenlei: "",
        page: 1, // 当前页
        pagesize: 10000, // 每页行数
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

    // 批量选择数据
    const multipleSelection = ref([]);
    const handleSelectionChange = (val) => {
        multipleSelection.value = val;
    };
    const orderPrice = computed(() => {
        var xiaojis = unref(multipleSelection).map((o) => o.xiaoji);
        var result = 0;
        for (var xiaoji of xiaojis) {
            result += parseFloat(xiaoji);
        }
        return result.toFixed(2);
    });

    const createOrder = () => {
        var sum_xiaoji = unref(orderPrice);
        var ids = unref(multipleSelection).map((o) => o.id);
        router.push({ path: "/admin/dingdan/add", query: { ids: ids.join(","), sum_xiaoji: sum_xiaoji } });
    };

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

    const deleteItems = (ids) => {
        return new Promise((resolve, reject) => {
            ElMessageBox.confirm("确定删除？")
                .then((res) => {
                    canGouwucheDelete(ids).then((res) => {
                        if (res.code == 0) {
                            ElMessage.success("删除成功");
                            loadList(search.page);
                            resolve(res.data);
                        } else {
                            ElMessage.error(res.msg);
                        }
                    });
                })
                .catch((err) => {
                    reject(err);
                });
        });
    };

    // 加载购物车列表方法
    const loadList = (page) => {
        // 加载
        if (unref(loading)) return;
        loading.value = true;
        search.page = page;

        http.post("/api/gouwuche/selectPages", search).then(
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
    const searchSubmit = () => {
        loadList(1);
    };
</script>

<style scoped lang="scss">
    .views-gouwuche-list {
    }
</style>
