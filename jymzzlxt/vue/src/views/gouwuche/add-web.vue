<template>
    <div class="views-gouwuche-web-add">
        <div>
            <e-container>
                <el-card class="box-card">
                    <template #header>
                        <div class="clearfix">
                            <span class="title"> 添加购物车 </span>
                        </div>
                    </template>

                    <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                        <el-form-item v-if="isRead" label="编号" prop="bianhao"> {{ form.bianhao }} </el-form-item>

                        <el-form-item v-if="isRead" label="名称" prop="mingcheng"> {{ form.mingcheng }} </el-form-item>

                        <el-form-item v-if="isRead" label="分类" prop="fenlei">
                            <e-select-view module="leibie" :value="form.fenlei" select="id" show="leibiemingcheng"></e-select-view>
                        </el-form-item>

                        <el-form-item v-if="isRead" label="价格" prop="jiage" :rules="[{validator:rule.checkNumber, message:'输入一个有效数字'}]"> {{ form.jiage }} </el-form-item>

                        <el-form-item v-if="isRead" label="图片" prop="tupian">
                            <div style="width: 100%; max-width: 120px">
                                <e-img :src="form.tupian" type="list"></e-img>
                            </div>
                        </el-form-item>

                        <el-form-item
                            label="购买数"
                            prop="goumaishu"
                            required
                            :rules="[{required:true, message:'请填写购买数'}, {validator:rule.checkNumber, message:'输入一个有效数字'}, {validator:rule.checkMin, value:1}, {validator:rule.checkMax, value:readMap.kucun}]"
                        >
                            <el-input type="number" placeholder="输入购买数" style="width: 450px" v-model.number="form.goumaishu" />
                        </el-form-item>

                        <el-form-item label="购买人" prop="goumairen"> <el-input v-model="form.goumairen" readonly style="width: 250px"></el-input> </el-form-item>

                        <el-form-item v-if="btnText">
                            <el-button type="primary" @click="submit">{{ btnText }}</el-button>
                        </el-form-item>
                    </el-form></el-card
                >
            </e-container>
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";
    import rule from "@/utils/rule";
    import router from "@/router";

    import { ref, reactive, computed } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { ElMessage, ElMessageBox } from "element-plus";
    import { useGouwucheCreateForm, canGouwucheInsert } from "@/module";

    const route = useRoute();
    const props = defineProps({
        id: [String, Number],
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
    const { form, readMap } = useGouwucheCreateForm(props.id);
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
                    canGouwucheInsert(form).then(
                        (res) => {
                            loading.value = false;
                            if (res.code == 0) {
                                emit("success", res.data);
                                if (props.isHouxu) {
                                    ElMessage.success("添加成功");
                                    router.go(-1);
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
</script>

<style scoped lang="scss">
    .views-gouwuche-web-add {
    }
</style>
