<template>
    <div class="views-yuyueguahao-updt">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 添加预约挂号 </span>
                    </div>
                </template>

                <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                    <el-form-item v-if="isRead" label="账号" prop="zhanghao"> {{ form.zhanghao }} </el-form-item>

                    <el-form-item v-if="isRead" label="姓名" prop="xingming"> {{ form.xingming }} </el-form-item>

                    <el-form-item v-if="isRead" label="职称" prop="zhicheng"> {{ form.zhicheng }} </el-form-item>

                    <el-form-item label="时间预约" prop="shijianyuyue" :rules="[{required:true, message:'请填写时间预约'}]">
                        <el-date-picker v-model="form.shijianyuyue" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" placeholder="选择日期"> </el-date-picker>
                    </el-form-item>

                    <el-form-item label="患者姓名" prop="huanzhexingming" required :rules="[{required:true, message:'请填写患者姓名'}]">
                        <el-input type="text" placeholder="输入患者姓名" style="width: 450px" v-model="form.huanzhexingming" />
                    </el-form-item>

                    <el-form-item label="年龄" prop="nianling" required :rules="[{required:true, message:'请填写年龄'}, {validator:rule.checkNumber, message:'输入一个有效数字'}]">
                        <el-input type="number" placeholder="输入年龄" style="width: 450px" v-model.number="form.nianling" />
                    </el-form-item>

                    <el-form-item label="手机" prop="shouji" required :rules="[{required:true, message:'请填写手机'}, {validator:rule.checkPhone, message:'请输入正确手机号码'}]">
                        <el-input type="text" placeholder="输入手机" style="width: 450px" v-model="form.shouji" />
                    </el-form-item>

                    <el-form-item label="备注" prop="beizhu"> <el-input type="textarea" v-model="form.beizhu"></el-input> </el-form-item>

                    <el-form-item label="挂号人" prop="guahaoren"> <el-input v-model="form.guahaoren" readonly style="width: 250px"></el-input> </el-form-item>

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

    import { ref, reactive, computed, watch } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { ElMessage, ElMessageBox } from "element-plus";
    import { useYuyueguahaoFindById, canYuyueguahaoFindById, canYuyueguahaoUpdate, canPaibanFindById } from "@/module";
    import { extend } from "@/utils/extend";

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
    const form = useYuyueguahaoFindById(props.id);
    const emit = defineEmits(["success"]);
    const formModel = ref();
    const loading = ref(false);

    const submit = () => {
        formModel.value.validate().then((res) => {
            if (loading.value) return;
            loading.value = true;
            canYuyueguahaoUpdate(form).then(
                (res) => {
                    loading.value = false;
                    if (res.code == 0) {
                        emit("success", res.data);
                        if (props.isHouxu) {
                            ElMessage.success("更新成功");
                            router.go(-1);
                        }
                    } else {
                        ElMessageBox.alert(res.msg);
                    }
                },
                (err) => {
                    loading.value = false;
                    ElMessageBox.alert(err.message);
                }
            );
        });
    };

    const readMap = reactive({});
    watch(
        () => form.paibanid,
        (id) => {
            canPaibanFindById(id).then((res) => {
                extend(readMap, res);
            });
        }
    );
</script>

<style scoped lang="scss">
    .views-yuyueguahao-updt {
    }
</style>
