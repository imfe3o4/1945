<template>
    <div class="views-dingdan-web-add">
        <div>
            <e-container>
                <el-card class="box-card">
                    <template #header>
                        <div class="clearfix">
                            <span class="title"> 添加订单 </span>
                        </div>
                    </template>

                    <el-dialog :title="'编辑收货地址'" v-model="editVisible" width="580px" :close-on-click-modal="false">
                        <ShouhuodizhiUpdt :is-houxu="false" :id="editId" v-if="editVisible" @success="onEditAddressSussess"></ShouhuodizhiUpdt>
                    </el-dialog>

                    <el-dialog :title="'添加收货地址'" v-model="addVisible" width="580px" :close-on-click-modal="false">
                        <ShouhuodizhiAdd :is-houxu="false" v-if="addVisible" @success="onAddAddressSussess"></ShouhuodizhiAdd>
                    </el-dialog>
                    <div class="order-checkout-address">
                        <div class="order-checkout-title">
                            <div class="product-item-title">确认收货信息</div>
                        </div>
                        <div class="order-select-address" id="order-select-address">
                            <div class="order-select-row" v-for="r in addressLists">
                                <div class="order-select-item" :class="{'order-select-item-selected':form.shouhuoxinxi === r.id}" @click="onSelectItem(r)">
                                    <div class="item-icon">
                                        <i class="icon select-icon-ttf dingwei-dingwei"></i>
                                    </div>
                                    <div class="item-text">
                                        <div class="item-address multi-line-1">{{ r.dizhi }}</div>
                                        <div class="item-name-phone">
                                            <span class="item-name">{{ r.shouhuoren }}</span>
                                            <span class="item-phone">{{ r.shouji }}</span>
                                        </div>
                                    </div>
                                    <div class="item-edit" @click.stop.prevent="onEditAddress(r)">编辑</div>
                                </div>
                            </div>

                            <div class="order-select-row">
                                <div class="order-select-item order-select-plus" @click="onAddAddress">
                                    <div class="item-icon">
                                        <i class="fa fa-plus"></i>
                                    </div>
                                    <div class="item-text">
                                        <span>添加新地址</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="order-checkout-info">
                        <div class="order-product-list">
                            <div class="order-checkout-title">
                                <div class="product-item-title">确认药品</div>
                            </div>
                            <div style="margin-bottom: 10px" class="card-list-content">
                                <div class="card-list-item card-list-item">
                                    <div class="card-info">
                                        <div class="card-info-title">药品</div>
                                    </div>
                                    <div class="card-price">
                                        <div class="card-price-now">价格</div>
                                    </div>
                                    <div class="card-number">
                                        <div class="card-price-now">购买数</div>
                                    </div>
                                    <div class="card-total">
                                        <div class="card-price-now">小计</div>
                                    </div>
                                </div>
                                <div class="card-list-item" v-for="(item) in dataSets" :key="item.id">
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
                                    <div class="card-number">{{ item.goumaishu }}</div>
                                    <div class="card-total price">￥<span class="card-total-span">{{ item.xiaoji }}</span></div>
                                </div>
                            </div>

                            <div class="order-checkout-title">
                                <div class="product-item-title">填写订单信息</div>
                            </div>
                            <div class="order-checkout-form">
                                <el-form :model="form" ref="formModel" label-position="right" label-width="140px" status-icon validate-on-rule-change>
                                    <el-form-item label="备注" prop="beizhu"> <el-input type="textarea" v-model="form.beizhu"></el-input> </el-form-item>
                                </el-form>
                            </div>

                            <div class="card-bottom-fix">
                                <div class="card-bottom-box">
                                    <div class="container-box">
                                        <div class="card-bottom-checkout">
                                            <div class="checkout-tips">共计 <i>{{ selectCount }}</i> 件商品，</div>
                                            <div class="checkout-price">
                                                订单金额：<span class="price">￥<i>{{ orderTotal }}</i></span>
                                            </div>
                                            <a href="javascript:;" class="checkout-button" @click="submitCheckout">创建订单</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div></el-card
                >
            </e-container>
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";
    import ShouhuodizhiAdd from "@/views/shouhuodizhi/add";
    import ShouhuodizhiUpdt from "@/views/shouhuodizhi/updt";
    import rule from "@/utils/rule";
    import router from "@/router";

    import { ref, reactive, computed, unref, watch } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { ElMessage, ElMessageBox } from "element-plus";
    import { useDingdanCreateForm, canDingdanInsert } from "@/module";
    import { extend } from "vue-design-plugin";

    const route = useRoute();
    const addressLists = ref([]);
    const loadaddressLists = async () => {
        addressLists.value = await DB.name("shouhuodizhi").where("tianjiaren", session("username")).order("id desc").select();
    };
    loadaddressLists();
    const onSelectItem = (item) => {
        var copys = ["shouhuoren", "shouji", "dizhi"];
        form.shouhuoxinxi = item.id;

        for (var c of copys) {
            form[c] = item[c];
        }
    };
    const editVisible = ref(false);
    const editId = ref(0);
    const onEditAddress = (item) => {
        editId.value = item.id;
        editVisible.value = true;
    };
    const onEditAddressSussess = () => {
        editVisible.value = false;
        loadaddressLists();
        ElMessage.success("编辑收货地址成功");
    };
    const addVisible = ref(false);
    const onAddAddress = () => {
        addVisible.value = true;
    };
    const onAddAddressSussess = () => {
        addVisible.value = false;
        loadaddressLists();
        ElMessage.success("添加收货地址成功");
    };
    const props = defineProps({
        btnText: {
            type: String,
            default: "",
        },
        isRead: {
            type: Boolean,
            default: true,
        },
        isHouxu: {
            type: Boolean,
            default: true,
        },
        labelWidth: {
            type: String,
            default: "140px",
        },
    });
    const { form } = useDingdanCreateForm();
    const emit = defineEmits(["success"]);
    const formModel = ref();
    const loading = ref(false);
    var submit = () => {
        return new Promise((resolve, reject) => {
            formModel.value
                .validate()
                .then((res) => {
                    if (loading.value) return;
                    loading.value = true;
                    canDingdanInsert(form).then(
                        (res) => {
                            loading.value = false;
                            if (res.code == 0) {
                                emit("success", res.data);
                                if (props.isHouxu) {
                                    ElMessage.success("添加成功");
                                    formModel.value.resetFields();
                                }
                            } else {
                                ElMessageBox.alert(res.msg);
                            }
                            resolve(res);
                        },
                        (err) => {
                            loading.value = false;
                            ElMessageBox.alert(err.message);
                            reject(err);
                        }
                    );
                })
                .catch((err) => {
                    reject(err);
                });
        });
    };

    const dataSets = ref([]);
    const loaddataSets = async () => {
        if (route.query.liji) {
            dataSets.value = JSON.parse(sessionStorage.getItem("JSON") || "[]");
            form._lijigoumai = "1";
            form._JSON = dataSets.value;
            form._biao = "dingdanshangpin";
        } else {
            dataSets.value = await DB.name("gouwuche").where("goumairen", session("username")).where("id", "in", route.query.ids).order("id desc").select();
        }
    };
    loaddataSets();
    form.targetIds = route.query.ids; // 添加提交值
    const selectCount = computed(() => {
        var tmpList = unref(dataSets);
        var count = 0;
        for (var item of tmpList) {
            count += item.goumaishu;
        }
        return count;
    });

    const orderTotal = ref(0);
    watch(
        dataSets,
        () => {
            var tmpList = unref(dataSets);
            var total = 0;
            for (var item of tmpList) {
                total += item.jiage * item.goumaishu;
            }
            orderTotal.value = total.toFixed(2);
            form.dingdanjine = total.toFixed(2);
        },
        { deep: true, immediate: true }
    );
    const submitCheckout = () => {
        submit()
            .then((res) => {
                if (res.code == 0) {
                    // 创建订单成功，跳转到支付页面
                    var row = res.data;
                    router.replace({
                        path: "/pay",
                        query: { biao: "dingdan", id: row.id, ordersn: row.dingdanhao, zongji: row.dingdanjine, isShaxiang: "", redirect: "/admin/dingdan/xiadanren" },
                    });
                }
            })
            .catch((err) => {});
    };
</script>

<style scoped lang="scss">
    .views-dingdan-web-add {
    }
</style>
