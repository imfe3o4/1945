<template>
    <div class="views-gouwuche-index">
        <div>
            <e-container>
                <div class="title-sn-title-shinei">
                    <div class="sn-title">
                        <span> 购物车 </span>
                    </div>
                    <div class="sn-content">
                        <div class="card-list">
                            <div class="card-list-select">
                                <div>
                                    <el-checkbox v-model="selectAll">全选</el-checkbox>
                                </div>
                                <div class="">全部商品（ {{ lists.length }} ）</div>
                                <div>
                                    <el-button class="delete-all" :disabled="selectValue.length == 0" plain @click="onBatchDelete">删除</el-button>
                                </div>
                            </div>
                            <div class="card-list-content">
                                <div class="card-list-item" v-for="(item) in lists" :key="item.id">
                                    <div class="card-selected">
                                        <el-checkbox v-model="selectValue" :label="item">
                                            <span></span>
                                        </el-checkbox>
                                    </div>
                                    <div class="card-info">
                                        <div class="card-img">
                                            <e-img :src="item.tupian" pb="100" />
                                        </div>
                                        <div class="card-content">
                                            <div class="card-title">{{ item.mingcheng }}</div>
                                        </div>
                                    </div>
                                    <div class="card-price">
                                        <div class="card-price-now price">￥{{ item.jiage }}</div>
                                    </div>
                                    <div class="card-number">
                                        <div class="card-number-box">
                                            <button class="card-button" type="button" @click="onMinus(item)">-</button>
                                            <input class="card-number-input" disabled :value="item.goumaishu" />
                                            <button @click="onPlus(item)" type="button" class="card-button">+</button>
                                        </div>
                                    </div>
                                    <div class="card-total price">￥<span class="card-total-span">{{ item.xiaoji }}</span></div>
                                    <div class="card-delete">
                                        <el-button icon="el-icon-delete" @click="onDelete(item)" plain>删除</el-button>
                                    </div>
                                </div>
                                <div class="card-list-empty" v-show="lists.length == 0">
                                    <div class="card-list-empty-icon">
                                        <img src="@/assets/images/card-empty.png" />
                                    </div>
                                    <div class="card-list-empty-text">
                                        <div class="empty-text">您的购物车是空的，</div>
                                        <div class="empty-text">去看看心仪的商品吧</div>
                                        <a href="javascript:;" class="empty-btn">去逛会儿</a>
                                    </div>
                                </div>
                            </div>
                            <div class="card-bottom-fix" ref="cardBottomFixElement">
                                <div class="card-bottom-box" :class="{'card-bottom-tip':isCardBottomTip}">
                                    <div class="container-box">
                                        <div class="card-bottom-checkout">
                                            <div class="checkout-tips">共计 <i>{{ selectCount }}</i> 件商品，</div>
                                            <div class="checkout-price">
                                                总价：<span class="price">￥<i>{{ totalPrice }}</i></span>
                                            </div>
                                            <a
                                                href="javascript:;"
                                                :disabled="selectValue.length == 0"
                                                class="checkout-button"
                                                :class="{disabled:selectValue.length == 0}"
                                                @click="gotoCheckout"
                                                >去结算</a
                                            >
                                        </div>
                                    </div>
                                </div>
                            </div>
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

    import { ref, reactive, watch, unref, onBeforeMount, computed, onMounted, onBeforeUnmount, nextTick } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { canGouwucheSelect, useGouwucheSelect, canGouwucheDelete, canGouwucheUpdate } from "@/module";
    import { extend } from "@/utils/extend";
    import { ElMessageBox, ElMessage } from "element-plus";
    import { useEventListener } from "@vueuse/core";

    const route = useRoute();
    const search = reactive({
        yaopinid: "",
        session_name: "goumairen",
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

    // 当前选中的值
    const selectValue = ref([]);
    // 是否选中全部
    const selectAll = ref(false);
    // 监听全选状态
    watch(selectAll, (newValue, oldValue) => {
        if (newValue) {
            selectValue.value = lists.value.map((item) => item);
        } else {
            selectValue.value = [];
        }
    });

    const deleteListItem = (item) => {
        for (var i = 0; i < lists.value.length; i++) {
            if (lists.value[i].id == item.id) {
                lists.value.splice(i, 1);
                break;
            }
        }
    };

    // 批量删除确认
    const onBatchDelete = async () => {
        try {
            var ids = unref(selectValue).map((item) => item.id);
            if (ids.length == 0) {
                return;
            }
            await ElMessageBox.confirm("确定删除全部商品？");

            var res = await canGouwucheDelete(ids);
            if (res.code == 0) {
                ElMessage.success("删除完成");
                // 重新加载列表
                for (var item of selectValue.value) {
                    deleteListItem(item);
                }
                selectValue.value = [];
                nextTick(updateBottomFix);
            }
        } catch (e) {}
    };

    const onDelete = async (item) => {
        try {
            if (!item) {
                return;
            }
            await ElMessageBox.confirm("确定删除该商品？");

            var res = await canGouwucheDelete(item.id);
            if (res.code == 0) {
                ElMessage.success("删除完成");
                // 重新加载列表
                deleteListItem(item);
                for (var i = 0; i < selectValue.value.length; i++) {
                    if (selectValue.value[i].id == item.id) {
                        selectValue.value.splice(i, 1);
                        break;
                    }
                }
                nextTick(updateBottomFix);
            }
        } catch (e) {}
    };

    const onMinus = async (item) => {
        var oldNumber = item.goumaishu;
        var val = oldNumber;
        if (val <= 1) {
            return;
        }
        val--;
        try {
            var res = await canGouwucheUpdate({ id: item.id, goumaishu: val });
            if (res.code == 0) {
                item.goumaishu = val;
                item.xiaoji = val * item.jiage;
            } else {
                ElMessage.error(res.msg);
            }
        } catch (e) {
            ElMessage.error(e.message);
        }
    };

    const onPlus = async (item) => {
        var oldNumber = item.goumaishu;
        var val = oldNumber;
        try {
            val++;
            var res = await canGouwucheUpdate({ id: item.id, goumaishu: val });
            if (res.code == 0) {
                item.goumaishu = val;
                item.xiaoji = val * item.jiage;
            } else {
                ElMessage.error(res.msg);
            }
        } catch (e) {
            ElMessage.error(e.message);
        }
    };

    const selectCount = computed(() => {
        var tmpList = unref(selectValue);
        if (tmpList.length == 0) {
            return 0;
        }
        return tmpList.reduce(function (a, b) {
            return a + b.goumaishu;
        }, 0);
    });

    const totalPrice = computed(() => {
        var tmpList = unref(selectValue);
        if (tmpList.length == 0) {
            return "0.00";
        }
        var price = tmpList.reduce(function (a, b) {
            return a + b.xiaoji;
        }, 0);
        return price.toFixed(2);
    });

    const gotoCheckout = () => {
        // 跳转结算页
        var tmpList = unref(selectValue);
        if (tmpList.length == 0) {
            ElMessage.error("请选择要结算的商品");
            return;
        }

        var ids = tmpList.map((item) => item.id).join(",");
        router.push({ path: "/dingdan/add", query: { ids: ids, sum_xiaoji: totalPrice.value } });
    };

    const cardBottomFixElement = ref(null);
    const isCardBottomTip = ref(false);
    function updateBottomFix() {
        if (cardBottomFixElement.value != null) {
            var ele = cardBottomFixElement.value;
            var boxRect = ele.getBoundingClientRect();

            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            var windowHeight = window.innerHeight || document.body.clientHeight;
            var offsetTop = boxRect.top + boxRect.height + scrollTop;

            if (offsetTop > scrollTop + windowHeight) {
                isCardBottomTip.value = true;
            } else {
                isCardBottomTip.value = false;
            }
        }
    }

    useEventListener(window, "scroll", updateBottomFix);
    useEventListener(window, "resize", updateBottomFix);

    onMounted(async () => {
        await nextTick();
        updateBottomFix();
        var index = 0;
        var timer = setInterval(() => {
            if (index > 10) {
                clearInterval(timer);
                return;
            }
            updateBottomFix();
            index++;
        }, 100);
    });
</script>

<style scoped lang="scss">
    .views-gouwuche-index {
    }
</style>
