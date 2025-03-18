<template>
    <div class="views-yaopin-index">
        <div>
            <e-container>
                <div class="title-sn-title1">
                    <div class="sn-title">
                        <span> 药品 </span>
                    </div>
                    <div class="sn-content">
                        <form action="javascript:;" @submit="searchSubmit" class="form-search">
                            <table class="jd-search">
                                <tbody>


                                    <tr>
                                        <td class="label">名称</td>
                                        <td>
                                            <el-input type="text" style="width: 150px" v-model="search.mingcheng" placeholder="请输入关键词"> </el-input>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label">分类</td>
                                        <td>
                                            <p class="search-radio">
                                                <a href="javascript:;" @click="selectRadio('fenlei','')" :class="{active:!search.fenlei}">全部</a>
                                                <a
                                                    href="javascript:;"
                                                    v-for="r in mapleibie1"
                                                    @click="selectRadio('fenlei',r.id)"
                                                    :class="{active:search.fenlei == r.id}"
                                                    v-text="r.leibiemingcheng"
                                                >
                                                </a>
                                            </p>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td>
                                            <el-button type="success" @click="searchSubmit">搜索</el-button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>

                        <el-row :gutter="30">
                            <el-col v-for="r in lists" :md="6" :key="r.id" style="margin-bottom: 20px">
                                <article class="single_product v-module-xiezi">
                                    <figure>
                                        <div class="product_thumb" @click="$goto('/yaopin/detail?id='+r.id)">
                                            <div class="label_product"></div>
                                            <e-img class="primary_img" :src="r.tupian" pb="100" :is-scale="false" />
                                        </div>
                                        <figcaption class="product_content">
                                            <h4 class="product_name"><a href="javascript:;" @click="$goto('/yaopin/detail?id='+r.id)"> {{ r.mingcheng }}</a></h4>
                                            <div class="price_box">
                                                <span class="current_price" v-if="r.jiage">￥{{ r.jiage }}</span>
                                            </div>
                                            <div class="add_to_cart">
                                                <a href="javascript:;" title="查看详情" @click="$goto('/yaopin/detail?id='+r.id)">查看详情</a>
                                            </div>
                                        </figcaption>
                                    </figure>
                                </article>
                            </el-col>
                        </el-row>

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
    import { canYaopinSelect, useYaopinSelect, canYaopinDelete } from "@/module";
    import { extend } from "@/utils/extend";
    import { ElMessageBox, ElMessage } from "element-plus";

    const route = useRoute();
    const search = reactive({
        keyword: "",
        bianhao: "",
        mingcheng: "",
        fenlei: "",
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
    // 统计数据
    const total = ref({});

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

    // 加载药品列表方法
    const loadList = (page) => {
        // 加载
        if (unref(loading)) return;
        loading.value = true;
        search.page = page;

        http.post("/api/yaopin/selectPages", search).then(
            (res) => {
                loading.value = false;
                if (res.code == 0) {
                    var data = res.data;
                    lists.value = data.lists.records;
                    totalCount.value = data.lists.total;

                    total.value = data.total;
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
    const selectRadio = (target, name) => {
        search[target] = name;
        searchSubmit(1);
    };

    const searchSubmit = (page = 1) => {
        loadList(1);
    };
    const mapleibie1 = DB.name("leibie").field("id,leibiemingcheng").order("id desc").selectRef();
</script>

<style scoped lang="scss">
    .views-yaopin-index {
    }
</style>
