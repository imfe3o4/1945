<template>
    <div class="views-xinlizhenliaofangan-updt">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 添加开具药方 </span>
                    </div>
                </template>

                <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                    <el-form-item v-if="isRead" label="账号" prop="zhanghao"> {{ form.zhanghao }} </el-form-item>

                    <el-form-item v-if="isRead" label="姓名" prop="xingming"> {{ form.xingming }} </el-form-item>

                    <el-form-item v-if="isRead" label="职称" prop="zhicheng"> {{ form.zhicheng }} </el-form-item>

                    <el-form-item v-if="isRead" label="患者姓名" prop="huanzhexingming"> {{ form.huanzhexingming }} </el-form-item>

                    <el-form-item v-if="isRead" label="年龄" prop="nianling" :rules="[{validator:rule.checkNumber, message:'输入一个有效数字'}]">
                        {{ form.nianling }}
                    </el-form-item>

                    <el-form-item v-if="isRead" label="挂号人" prop="guahaoren"> {{ form.guahaoren }} </el-form-item>

                    <el-form-item label="诊疗方案" prop="zhenliaofangan" required :rules="[{required:true, message:'请填写诊疗方案'}]">
                        <el-input type="textarea" v-model="form.zhenliaofangan"></el-input>
                    </el-form-item>

                    <el-form-item label="处方" prop="chufang" required :rules="[{required:true, message:'请填写处方'}]">
                        <el-input type="textarea" v-model="form.chufang"></el-input>
                    </el-form-item>

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
    import { useXinlizhenliaofanganFindById, canXinlizhenliaofanganFindById, canXinlizhenliaofanganUpdate, canYuyueguahaoFindById } from "@/module";
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
    const form = useXinlizhenliaofanganFindById(props.id);
    const emit = defineEmits(["success"]);
    const formModel = ref();
    const loading = ref(false);

    const submit = () => {
        formModel.value.validate().then((res) => {
            if (loading.value) return;
            loading.value = true;
            canXinlizhenliaofanganUpdate(form).then(
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
        () => form.yuyueguahaoid,
        (id) => {
            canYuyueguahaoFindById(id).then((res) => {
                extend(readMap, res);
            });
        }
    );
</script>

<style scoped lang="scss">
    .views-xinlizhenliaofangan-updt {
    }
</style>
