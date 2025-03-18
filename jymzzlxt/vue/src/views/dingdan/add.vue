<template>
    <div class="views-dingdan-add">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 添加订单 </span>
                    </div>
                </template>

                <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                    <el-form-item label="订单号" prop="dingdanhao" :rules="[{required:true, message:'请填写订单号'}]">
                        <el-input type="text" placeholder="输入订单号" style="width: 450px" v-model="form.dingdanhao" />
                    </el-form-item>

                    <el-form-item label="商品" prop="shangpin">
                        <div id="dataListshangpin" style="text-align: left">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>编号</th>
                                        <th>名称</th>
                                        <th>分类</th>
                                        <th>价格</th>
                                        <th>购买数</th>
                                        <th>小计</th>
                                        <th>购买人</th>
                                        <th>图片</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="dataMap in dataSets">
                                        <td>{{ dataMap.bianhao }}</td>
                                        <td>{{ dataMap.mingcheng }}</td>
                                        <td><e-select-view module="leibie" :value="dataMap.fenlei" select="id" show="leibiemingcheng"></e-select-view></td>
                                        <td>{{ dataMap.jiage }}</td>
                                        <td>{{ dataMap.goumaishu }}</td>
                                        <td>{{ dataMap.xiaoji }}</td>
                                        <td>{{ dataMap.goumairen }}</td>
                                        <td>
                                            <div style="width: 100%; max-width: 120px">
                                                <e-img :src="dataMap.tupian" type="list"></e-img>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </el-form-item>

                    <el-form-item
                        label="订单金额"
                        prop="dingdanjine"
                        required
                        :rules="[{required:true, message:'请填写订单金额'}, {validator:rule.checkNumber, message:'输入一个有效数字'}]"
                    >
                        <el-input type="number" placeholder="输入订单金额" style="width: 450px" v-model.number="form.dingdanjine" />
                    </el-form-item>

                    <el-form-item label="收货信息" prop="shouhuoxinxi" required :rules="[{required:true, message:'请填写收货信息'}]">
                        <div style="width: 100%">
                            <e-select-list :model="form" v-model="form.shouhuoxinxi" module="shouhuodizhi" select-update="shouhuoren,shouji,dizhi" search-update=""></e-select-list>
                            <table>
                                <tr>
                                    <td width="120">收货人</td>
                                    <td>{{ form.shouhuoren }}</td>
                                </tr>
                                <tr>
                                    <td width="120">手机</td>
                                    <td>{{ form.shouji }}</td>
                                </tr>
                                <tr>
                                    <td width="120">地址</td>
                                    <td>{{ form.dizhi }}</td>
                                </tr>
                            </table>
                        </div>
                    </el-form-item>

                    <el-form-item label="收货人" prop="shouhuoren"> <el-input type="text" placeholder="输入收货人" style="width: 450px" v-model="form.shouhuoren" /> </el-form-item>

                    <el-form-item label="手机" prop="shouji"> <el-input type="text" placeholder="输入手机" style="width: 450px" v-model="form.shouji" /> </el-form-item>

                    <el-form-item label="地址" prop="dizhi"> <el-input type="text" placeholder="输入地址" style="width: 450px" v-model="form.dizhi" /> </el-form-item>

                    <el-form-item label="备注" prop="beizhu"> <el-input type="textarea" v-model="form.beizhu"></el-input> </el-form-item>

                    <el-form-item label="下单人" prop="xiadanren"> <el-input v-model="form.xiadanren" readonly style="width: 250px"></el-input> </el-form-item>

                    <el-form-item v-if="btnText">
                        <el-button type="primary" @click="submit">{{ btnText }}</el-button>
                    </el-form-item>
                </el-form></el-card
            >
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";
    import rule from "@/utils/rule";
    import router from "@/router";

    import { ref, reactive, computed, unref } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { ElMessage, ElMessageBox } from "element-plus";
    import { useDingdanCreateForm, canDingdanInsert } from "@/module";
    import { extend } from "vue-design-plugin";

    const route = useRoute();
    const props = defineProps({
        btnText: {
            type: String,
            default: "保存",
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
</script>

<style scoped lang="scss">
    .views-dingdan-add {
    }
</style>
